from params_helper import get_param_reducer_declaration, get_param_reducer_implementation


class ReducerPage:

    def __init__(self, name, params) -> None:
        self.name = name[0].lower() + name[1:] + "Reducer"
        self.state_name = name + "State"
        self.params = params

    def build_page(self):
        res = self.build_declaration()
        res += self.build_implementation()
        return res.replace('°', '{').replace('#', '}')

    def build_declaration(self):
        res = f"final {self.name} = combineReducers<{self.state_name}>([\n\t"
        res += "\n\t".join([get_param_reducer_declaration(row,
                           self.state_name) for row in self.params])
        res += "\n]);"
        return res

    def build_implementation(self):
        res = "\n\n"
        res += "\n\n".join([get_param_reducer_implementation(
            row, self.state_name) for row in self.params])
        res += "\n"
        return res


if __name__ == "__main__":
    state = ReducerPage("Prova", [{'type': 'List<int>', 'name': 'param1', 'is_comp': False}, {
        'type': 'int', 'name': 'param2', 'is_comp': False}, {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}])
    print(state.build_page())
