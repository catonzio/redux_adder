from params_helper import *


class StatePage:

    def __init__(self, name, params) -> None:
        self.name = name + "State"
        self.params = params
        self.path = "states"

    def build_page(self):
        res = f"class {self.name} °\n"
        res += self.build_params_declaration()
        res += self.build_constructor()
        res += self.build_copy_with()
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

    def build_copy_with(self):
        res = f"\n\t{self.name} copyWith(°\n\t\t"
        res += "\n\t\t".join([get_copy_with_arg(row)
                             for row in self.params])
        res += "\n\t#) °\n\t\t"
        res += f"return {self.name}(\n\t\t\t"
        res += "\n\t\t\t".join([get_copy_with_body(row)
                               for row in self.params])
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
    state = StatePage("Prova", [{'type': 'List<int>', 'name': 'param1', 'is_comp': False}, {
                      'type': 'int', 'name': 'param2', 'is_comp': False}, {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}])
    print(state.build_page())
