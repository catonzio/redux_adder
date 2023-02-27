from helper import capitalize, indented_line


class WidgetPage:

    def __init__(self, name) -> None:
        self.name = capitalize(name)
        self.page_name = self.name + "Page"
        self.view_model_name = self.name + "ViewModel"

    def build_page(self):
        res = f"import '{self.name.lower()}_vm.dart';"
        res += "\nimport '..\\app\\app_state.dart';"
        res += f"\n\nclass {self.page_name} extends StatelessWidget °\n"
        res += indented_line(
            f"static const String routeName = \"{self.page_name}\";\n", 1)
        res += indented_line(
            f"const {self.page_name}(°Key? key#) : super(key: key);\n", 1)
        res += indented_line("@ovveride", 1)
        res += indented_line("Widget build(BuildContext context) °", 1)
        res += indented_line(
            f"return StoreConnector<AppState, {self.view_model_name}>(", 2)
        res += indented_line(
            f"converter: (store) => {self.view_model_name}.fromStore(store: store),", 3)
        res += indented_line(
            f"builder: (context, vm) => _{self.page_name}(viewModel: vm),", 3)
        res += indented_line(")", 2)
        res += indented_line("#", 1)
        res += "\n#"
        res += "\n\n"
        res += f"class _{self.page_name} extends StatelessWidget °\n"
        res += indented_line(f"final {self.view_model_name} viewModel;\n", 1)
        res += indented_line(
            f"const _{self.page_name}(°required this.viewModel#);\n", 1)
        res += indented_line(f"@override", 1)
        res += indented_line("Widget build(BuildContext context) °", 1)
        res += indented_line("return Container();", 2)
        res += indented_line("#", 1)
        res += "\n#"
        return res.replace('°', '{').replace('#', '}')


if __name__ == "__main__":
    p = WidgetPage("prova")
    print(p.build_page())
