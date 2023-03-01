
import json
import os
from helper import change_case, print_header, write_pages, BASE_DIR, capitalize

from pages.action_page import ActionPage
from pages.middleware_page import MiddlewarePage
from pages.reducer_page import ReducerPage
from pages.state_page import StatePageBuilder
from pages.view_model_page import ViewModelPage
from pages.widget_page import WidgetPage
from helper import get_folder_components, indented_line


def get_params_from_user():
    params = []

    print("\nInsert the parameters one by one, specifying the correct Dart type, the name (camelCase) and if it is another redux component (default false).\nInsert 'exit' to stop.")
    while True:
        try:
            print("\nParameter -> type name [component=False]")
            inp = input(" " * len("Parameter -> "))
            if inp.lower() == "exit":
                break
            inp = inp.split(" ")
            if len(inp) == 2:
                inp.append("False")
            type, name, is_other_component = inp
            is_other_component = True if is_other_component.lower() == "true" else False
            params.append({'type': type, 'name': name,
                           'is_comp': is_other_component})
        except Exception:
            print("\nAn exception has occurred. try again.")
    print(params)
    return params


def get_name_params_from_json(input_file):
    file_content = ""
    with open(input_file, 'r') as f:
        file_content = json.loads(f.read())
    component_name = file_content["name"]
    params = file_content["params"]
    return component_name, params


def write_redux_component(component_name, params):
    camel_case = change_case(component_name)
    camel_case = camel_case[0].upper() + camel_case[1:]

    state_page = StatePageBuilder(camel_case, params).build_page()
    vm_page = ViewModelPage(camel_case, params).build_page()
    reducer_page = ReducerPage(camel_case, params).build_page()
    middleware_page = MiddlewarePage(camel_case).build_page()
    action_page = ActionPage(camel_case, params).build_page()
    widget_page = WidgetPage(camel_case).build_page()

    pages = [[state_page, "state"], [vm_page, 'vm'],
             [reducer_page, 'reducer'], [middleware_page, 'middleware'], [action_page, 'action'], [widget_page, 'page']]

    write_pages(component_name, pages)


def new_redux_component(input_file=None, input_directory=None):
    print_header("Creating new component")

    if input_file is None and input_directory is None:
        component_name = input(
            "Insert the name of the component (snake_case): ")
        params = get_params_from_user()
        write_redux_component(component_name, params)

    elif input_file is not None and input_directory is None:
        component_name, params = get_name_params_from_json(input_file)
        write_redux_component(component_name, params)

    elif input_file is None and input_directory is not None:
        files = [os.path.join(input_directory, f)
                 for f in os.listdir(input_directory)]
        names_params = [get_name_params_from_json(f) for f in files]
        for component_name, params in names_params:
            write_redux_component(component_name, params)
    params = get_folder_components()
    make_app_component(params=params)
    create_store_page(params=params)


def refresh_redux_component(file, directory):
    print_header("Refreshing the component not yet implemented")


def init_project():
    os.makedirs(BASE_DIR, exist_ok=True)
    params = get_folder_components()
    make_app_component(params)
    create_store_page(params)
    write_main_page()


def make_app_component(params=None):
    params = params if params is not None else get_folder_components()
    page = StatePageBuilder("app", params).build_page()
    reducer = ReducerPage("app", params).build_app_page()
    write_pages("app", [[page, "state"], [reducer, "reducer"]])


def create_store_page(params=None):
    params = params if params is not None else get_folder_components()
    res = "\n".join(
        [f"import '{param['name'].replace('State', '')}/{param['name'].replace('State', '')}_middleware.dart';" for param in params])
    res += indented_line("import 'app/app_state.dart';")
    res += indented_line("import 'app/app_reducer.dart';")
    res += indented_line("\nStore<AppState> createStore() °")
    res += indented_line("return Store(", 1)
    res += indented_line("appReducer,", 2)
    res += indented_line("initialState: AppState.initial(),", 2)
    res += indented_line("distrinct: true,", 2)
    res += indented_line("middleware: [", 2)
    res += "".join([indented_line(
        f"create{param['type'].replace('State', '')}Middleware(),", 3) for param in params])
    res += indented_line("]", 2)
    res += indented_line(");", 1)
    res += indented_line("#")
    res = res.replace('°', '{').replace('#', '}')
    with open(os.path.join(BASE_DIR, "store.dart"), "w") as f:
        f.write(res)


def write_main_page():
    res = "import 'package:redux/redux.dart';\nimport 'package:flutter_redux/flutter_redux.dart';\n"
    res += indented_line("void main() °")
    res += indented_line("WidgetsFlutterBinding.ensureInitialized();", 1)
    res += indented_line("runApp(MyApp())", 1)
    res += indented_line("#\n")

    res += indented_line("class MyApp extends StatelessWidget °")
    res += indented_line("MyApp(°super.key#);", 1)
    res += indented_line("final Store<AppState> store = createStore();\n", 1)
    res += indented_line("@override", 1)
    res += indented_line("Widget build(BuildContext context) °", 1)
    res += indented_line("return StoreProvider<AppState>(", 2)
    res += indented_line("store: store,", 3)
    res += indented_line("child: MaterialApp(", 3)
    res += indented_line("title: 'AppName',", 4)
    res += indented_line("initialRoute: HomePage.routeName,", 4)
    res += indented_line("onGenerateRoute: RouteGenerator.generateRoute,", 4)
    res += indented_line("navigatorKey: Keys.navigatorKey,", 4)
    res += indented_line(")", 3)
    res += indented_line(");", 2)
    res += indented_line("}", 1)
    res += indented_line("}")
    res = res.replace('°', '{').replace('#', '}')
    with open(os.path.join(BASE_DIR, "..", "main.dart"), "w") as f:
        f.write(res)


if __name__ == "__main__":
    # new_redux_component()
    write_main_page()
