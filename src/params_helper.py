from helper import get_action_from_name, get_snake_action_name


def get_param_declaration(param):
    return "final " + param['type'] + " " + param['name'] + ";"


def get_param_constructor(param):
    return "required this." + param['name'] + ","


def get_param_initial(param):
    initialization = ""
    if param['is_comp']:
        initialization = f"{param['type']}.initial()"
    else:
        if param['type'] == 'int':
            initialization = "0"
        elif param['type'] == "String":
            initialization = "\"\""
        elif param['type'] == "bool":
            initialization = "false"
        elif param['type'] == "DateTime":
            initialization = "DateTime.now()"
        elif 'List' in param['type']:
            new_type = param['type'].replace(
                "List", "").replace("<", "").replace(">", "")
            initialization = f"<{new_type}>[]"
    return param['name'] + f": {initialization},"


def get_copy_with_arg(param):
    return param['type'] + "? " + param['name'] + ","


def get_copy_with_body(param):
    return param['name'] + ": " + param['name'] + " ?? this." + param['name'] + ","


def get_param_from_json(param):
    return param['name'] + ": json.decode(json['" + param['name'] + "']),"


def get_param_to_json(param):
    return "'" + param['name'] + "': json.encode(" + param['name'] + "),"


def get_param_equals(param):
    return param['name'] + " == other." + param['name']


def get_param_hash_code(param):
    return param['name'] + ".hashCode"


def get_param_reducer_declaration(param, state_name):
    action_name = get_action_from_name(param['name'], state_name)
    snake_action_name = get_snake_action_name(action_name)
    return f"TypedReducer<{state_name}, {action_name}>({snake_action_name}),"


def get_param_reducer_implementation(param, state_name):
    action_name = get_action_from_name(param['name'], state_name)
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
