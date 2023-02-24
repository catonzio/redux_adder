from params_helper import *


class ViewModelPage:

    def __init__(self, name) -> None:
        self.name = name + "ViewModel"
        self.state_name = name + "State"
        self.params = [{'type': self.state_name,
                        'name': 'state', 'is_comp': True}]
        self.path = "view_models"

    def build_page(self):
        res = "import 'json';\nimport 'package:openeyed/redux/states/app_state.dart';\nimport 'package:redux/redux.dart';\n\n"
        res += f"class {self.name} °\n"
        res += self.build_params_declaration()
        res += self.build_from_store()
        res += self.build_constructor()
        res += self.build_initial()
        res += self.build_from_json()
        res += self.build_to_json()
        res += self.build_equals()
        res += self.build_hash_code()
        res += "#"
        return res.replace('°', '{').replace('#', '}')

    def build_params_declaration(self):
        res = "\n\t"
        res += "\n\t".join([get_param_declaration(row)
                           for row in self.params])
        res += "\n"
        return res

    def build_constructor(self):
        res = f"\n\t{self.name}(°\n\t\t"
        res += "\n\t\t".join([get_param_constructor(row)
                             for row in self.params])
        res += "\n\t#);\n"
        return res

    def build_from_store(self):
        res = f"\n\tstatic {self.name} fromStore(Store<AppState> store) °\n\t\t"
        res += f"return {self.name}(\n\t\t\t"
        res += f"state: store.state.pagesState.{self.state_name[0].lower() + self.state_name[1:]}"
        res += "\n\t\t);"
        res += "\n\t#\n"
        return res

    def build_initial(self):
        res = f"\n\tfactory {self.name}.initial() °\n\t\t"
        res += f"return {self.name}(\n\t\t\t"
        res += "\n\t\t\t".join([get_param_initial(row)
                               for row in self.params])
        res += "\n\t\t);"
        res += "\n\t#\n"
        return res

    def build_from_json(self):
        res = f"\n\tfactory {self.name}.fromJson(Map<String, dynamic> json) °\n\t\t"
        res += f"return {self.name}(\n\t\t\t"
        res += "\n\t\t\t".join([get_param_from_json(row)
                               for row in self.params])
        res += "\n\t\t);"
        res += "\n\t#\n"
        return res

    def build_to_json(self):
        res = "\n\tMap<String, dynamic> toJson() => °\n\t\t"
        res += "\n\t\t".join([get_param_to_json(row)
                             for row in self.params])
        res += "\n\t#;\n"
        return res

    def build_equals(self):
        res = f"\n\t@override\n\tbool operator ==(Object other) => \n\t\tidentical(this, other) || \n\t\tother is {self.name} && \n\t\t"
        res += " &&\n\t\t".join([get_param_equals(row)
                                for row in self.params])
        res += ";\n"
        return res

    def build_hash_code(self):
        res = "\n\t@override\n\tint get hashCode => super.hashCode ^ \n\t\t"
        res += " ^\n\t\t".join([get_param_hash_code(row)
                               for row in self.params])
        res += ";\n"
        return res


if __name__ == "__main__":
    state = ViewModelPage("Prova")
    print(state.build_page())
