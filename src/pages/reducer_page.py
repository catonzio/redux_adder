from params_helper import get_param_reducer_declaration, get_param_reducer_implementation, get_components_reducer_declaration
from helper import capitalize, uncapitalize, indented_line


class ReducerPage:

    def __init__(self, name, params) -> None:
        self.name = uncapitalize(name)
        self.reducer_name = uncapitalize(name) + "Reducer"
        self.state_name = capitalize(name) + "State"
        self.params = params

    def build_app_page(self):
        params_names = [uncapitalize(
            p["name"].replace("State", "")) for p in self.params]
        res = f"import 'package:redux/redux.dart';\nimport '{self.name}_state.dart';\n"
        res += "".join([f"import '../{pn}/{pn}_reducer.dart';" for pn in params_names])
        res += f"\n\nfinal {self.reducer_name} = combineReducers<{self.state_name}>(["
        res += indented_line(
            f"(state, action) => {capitalize(self.state_name)}(", 1)
        res += "".join([indented_line(
            f"{row['name']}: {uncapitalize(row['name'].replace('State', ''))}Reducer(state.{row['name']}, action),", 2) for row in self.params])
        res += indented_line(")", 1)
        res += "\n]);"
        return res.replace('°', '{').replace('#', '}')

    def build_page(self):
        res = f"import 'package:redux/redux.dart';\nimport '{self.name}_state.dart';\nimport '{self.name}_action.dart';\n\n"
        res += self.build_declaration()
        res += self.build_implementation()
        return res.replace('°', '{').replace('#', '}')

    def build_declaration(self):
        res = f"final {self.reducer_name} = combineReducers<{self.state_name}>([\n\t"
        res += "\n\t".join([get_param_reducer_declaration(row,
                           self.state_name) for row in self.params if not row['is_comp']])
        res += get_components_reducer_declaration(
            [p for p in self.params if p['is_comp'] and not p['name'].lower() in self.name.lower()], self.state_name)
        print([p for p in self.params if p['is_comp']
              and not p['name'].lower() in self.name.lower()])
        res += "\n]);"
        return res

    def build_implementation(self):
        res = "\n\n"
        res += "\n\n".join([get_param_reducer_implementation(
            row, self.state_name) for row in self.params if not row['is_comp']])
        res += "\n"
        return res


if __name__ == "__main__":
    state = ReducerPage("Prova", [{'type': 'List<int>', 'name': 'param1', 'is_comp': False}, {
        'type': 'int', 'name': 'param2', 'is_comp': False}, {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}])
    print(state.build_page())
