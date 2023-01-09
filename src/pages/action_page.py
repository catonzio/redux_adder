from params_helper import build_action_declaration


class ActionPage:

    def __init__(self, name, params) -> None:
        self.state_name = name + "State"
        self.params = params

    def build_page(self):
        res = "\n\n".join([build_action_declaration(row, self.state_name)
                          for row in self.params])
        return res.replace('°', '{').replace('#', '}')


if __name__ == "__main__":
    state = ActionPage("Prova", [{'type': 'List<int>', 'name': 'param1', 'is_comp': False}, {
        'type': 'int', 'name': 'param2', 'is_comp': False}, {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}])
    print(state.build_page())
