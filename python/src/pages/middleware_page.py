from helper import indented_line


class MiddlewarePage:

    def __init__(self, name) -> None:
        self.name = "create" + name + "Middleware"

    def build_page(self):
        res = "import 'package:redux/redux.dart';\n"
        res += "import '../app/app_state.dart';\n\n"
        res += f"Middleware<AppState> {self.name}() °"
        res += indented_line(
            "return (Store<AppState> store, dynamic action, NextDispatcher next) async °", 1)
        res += indented_line("next(action);", 2)
        res += indented_line("#;", 1)
        res += "\n#"
        return res.replace('°', '{').replace('#', '}')


if __name__ == "__main__":
    state = MiddlewarePage("Prova")
    print(state.build_page())
