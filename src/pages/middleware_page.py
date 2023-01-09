class MiddlewarePage:

    def __init__(self, name) -> None:
        self.name = "create" + name + "Middleware"

    def build_page(self):
        res = "import 'package:redux/redux.dart';\n"
        res += "import 'package:openeyed/redux/states/app_state.dart';\n\n"
        res += f"Middleware<AppState> {self.name}() °\n\t"
        res += "return (Store<AppState> store, dynamic action, NextDispatcher next) async °\n\t\t"
        res += "next(action);"
        res += "\n\t#;"
        res += "\n#"
        return res.replace('°', '{').replace('#', '}')


if __name__ == "__main__":
    state = MiddlewarePage("Prova")
    print(state.build_page())
