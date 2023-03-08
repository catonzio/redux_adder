from helper import get_action_from_name, get_snake_action_name, indented_line, uncapitalize


def get_param_declaration(param):
    return "final " + param['type'] + " " + param['name'] + ";"


def get_param_constructor(param):
    return ("required " if not param['type'].endswith("?") else "") + "this." + param['name'] + ","


def get_param_initial(param):
    initialization = ""
    if param['is_comp']:
        initialization = f"{param['type']}.initial()"
    elif not param['type'].endswith("?"):
        if param['type'] == 'int':
            initialization = "0"
        elif param['type'] == "String":
            initialization = "\"\""
        elif param['type'] == "bool":
            initialization = "false"
        elif param['type'] == "DateTime":
            initialization = "DateTime.now()"
        elif 'List' in param['type']:
            new_type = param['type'][param['type'].index(
                "<")+1:param['type'].index(">")]
            initialization = f"<{new_type}>[]"

    return param['name'] + f": {initialization}," if not param['type'].endswith("?") else ""


def get_copy_with_arg(param):
    return param['type'] + "? " + param['name'] + ","


def get_copy_with_body(param):
    return param['name'] + ": " + param['name'] + " ?? this." + param['name'] + ","


def get_param_from_json(param):
    if "function" in param['type'].lower():
        return ""
    else:
        if param["is_comp"]:
            return f"{param['name']}: {param['type']}.fromJson(json['" + param['name'] + "']),"
        else:
            return f"{param['name']}: jsonDecode(json['" + param['name'] + "']),"


def get_param_to_json(param):
    if "function" in param['type'].lower():
        return ""
    else:
        if param['is_comp']:
            return f"'{param['name']}': {param['name']}.toJson(),"
        else:
            return f"'{param['name']}': jsonEncode({param['name']}),"


def get_param_equals(param):
    return param['name'] + " == other." + param['name'] if "function" not in param['type'].lower() else ""


def get_param_hash_code(param):
    return param['name'] + ".hashCode" if "function" not in param['type'].lower() else ""


def get_param_function_vm(param, action_name):
    return f"""{param['name']}: ({param['type']} value) =>
          store.dispatch({action_name}(value: value)),"""


def get_param_reducer_declaration(param, state_name):
    if param["is_comp"]:
        res = "(state, action) =>"
        res += indented_line(
            f"{uncapitalize(param['name'].replace('State', ''))}Reducer(state, action),", 2)
        return res
    else:
        action_name = get_action_from_name(
            param['name'], state_name.replace("State", ""))
        snake_action_name = get_snake_action_name(action_name)
        return f"TypedReducer<{state_name}, {action_name}>({snake_action_name}),"


def get_components_reducer_declaration(params, state_name):
    if not params:
        return ""
    res = indented_line(f"(state, action) => {state_name}(", 1)
    res += "".join(indented_line(
        f"{param['name']}: {uncapitalize(param['name'].replace('State', ''))}Reducer(state.{param['name']}, action),", 2) for param in params)
    res += indented_line(")", 1)
    return res


def get_param_reducer_implementation(param, state_name):
    action_name = get_action_from_name(
        param['name'], state_name.replace("State", ""))
    snake_action_name = get_snake_action_name(action_name)
    res = f"{state_name} {snake_action_name}({state_name} state, {action_name} action) °\n\t"
    res += f"return state.copyWith(\n\t\t"
    res += f"{param['name']}: action.value"
    res += f"\n\t);"
    res += "\n#"
    return res


def build_action_declaration(param, state_name):
    action_name = get_action_from_name(param['name'], state_name)
    res = f"class {action_name} °"
    res += f"\n\tfinal {param['type']} value;"
    res += f"\n\n\t{action_name}(°required this.value#);"
    res += "\n#"
    return res
