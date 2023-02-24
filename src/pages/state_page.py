from params_helper import *


class StatePageBuilder:

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


class StatePageAdder:

    def __init__(self, parameter, file_path, class_name):
        self.parameter = parameter
        self.file_path = file_path
        self.class_name = class_name

    def add_parameter(self):
        with open(self.file_path, "r") as f:
            content = f.read()
        lines = content.split("\n")
        constructor_si, constructor_ei = self.find_constructor(lines)
        return lines[constructor_si:constructor_ei]

    def find_parameters_declaration(self, lines):
        pass

    def find_constructor(self, lines):
        start_mask = f"\t{self.class_name}({{"
        end_mask = "\t});"
        start_id = [i for i, el in enumerate(lines) if start_mask in el][0]
        end_id = [i for i, el in enumerate(
            lines[start_id:]) if end_mask in el][0] + start_id
        return (start_id + 1, end_id)

    def find_copy_with(self, lines):
        start_mask = f"\t{self.name} copyWith({{"
        end_mask = "\t});"
        start_id = [i for i, el in enumerate(lines) if start_mask in el][0]
        end_id = [i for i, el in enumerate(
            lines[start_id:]) if end_mask in el][0] + start_id
        return (start_id + 1, end_id)

    def find_initial(self, lines):
        pass

    def find_from_json(self, lines):
        pass

    def find_to_json(self, lines):
        pass

    def find_equals(self, lines):
        pass

    def find_hash_code(self, lines):
        pass


if __name__ == "__main__":
    # state = StatePageBuilder("Prova", [{'type': 'List<int>', 'name': 'param1', 'is_comp': False}, {
    #     'type': 'int', 'name': 'param2', 'is_comp': False}, {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}])
    # print(state.build_page())
    adder = StatePageAdder(
        {'type': "GuardiaPGListState", 'name': "guardie", 'is_comp': True}, "outputs/prova_state", "ProvaState")
    print(adder.add_parameter())
