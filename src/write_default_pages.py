import json
import helper as h
import os
from pages.action_page import ActionPage
from pages.middleware_page import MiddlewarePage
from pages.reducer_page import ReducerPage
from pages.state_page import StatePageBuilder
from pages.view_model_page import ViewModelPage
from pages.widget_page import WidgetPage
from helper import get_folder_components, indented_line


def write_redux_component(component_name, params):
    camel_case = h.change_case(component_name)
    camel_case = camel_case[0].upper() + camel_case[1:]

    state_page = StatePageBuilder(camel_case, params).build_page()
    vm_page = ViewModelPage(camel_case, params).build_page()
    reducer_page = ReducerPage(camel_case, params).build_page()
    middleware_page = MiddlewarePage(camel_case).build_page()
    action_page = ActionPage(camel_case, params).build_page()
    widget_page = WidgetPage(camel_case).build_page()

    pages = [[state_page, "state"], [vm_page, 'vm'],
             [reducer_page, 'reducer'], [middleware_page, 'middleware'], [action_page, 'action'], [widget_page, 'page']]

    h.write_pages(component_name, pages, dir=h.base_dir)


def make_homepage_component():
    params = [{"type": "int", "name": "counter", "is_comp": False}]
    write_redux_component(component_name="home", params=params)
    path = os.path.join(h.base_dir, "..", "models")
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, "home.json"), 'w') as f:
        f.write(json.dumps({"name": "home", "params": params}, indent=4))
    setup_home_page()

def setup_home_page():
    code = """
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
            title: const Text("MyApp"),
        ),
        body: Center(
            child: Text(
            "${viewModel.state.counter}",
            style: const TextStyle(fontSize: 32),
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                viewModel.updateCounter!(viewModel.state.counter + 1),
            child: const Icon(Icons.add)),
        ),
    );
}
}
    """
    path = os.path.join(h.base_dir, "home", "home_page.dart")
    with open(path, 'r') as f:
        file_content = f.read().split("\n")
    result = "\n".join(file_content[:28])
    result += code
    with open(path, 'w') as f:
        f.write(result)


def make_app_component(params=None):
    params = params if params is not None else get_folder_components()
    page = StatePageBuilder("app", params).build_page()
    reducer = ReducerPage("app", params).build_app_page()
    h.write_pages("app", [[page, "state"], [
        reducer, "reducer"]], dir=h.base_dir)


def create_store_page(params=None):
    params = params if params is not None else get_folder_components()
    res = "import 'package:redux/redux.dart';\n"
    res += "\n".join(
        [f"import '{param['name'].replace('State', '')}/{param['name'].replace('State', '')}_middleware.dart';" for param in params])
    res += indented_line("import 'app/app_state.dart';")
    res += indented_line("import 'app/app_reducer.dart';")
    res += indented_line("\nStore<AppState> createStore() °")
    res += indented_line("return Store(", 1)
    res += indented_line("appReducer,", 2)
    res += indented_line("initialState: AppState.initial(),", 2)
    res += indented_line("distinct: true,", 2)
    res += indented_line("middleware: [", 2)
    res += "".join([indented_line(
        f"create{param['type'].replace('State', '')}Middleware(),", 3) for param in params])
    res += indented_line("]", 2)
    res += indented_line(");", 1)
    res += indented_line("#")
    res = h.sanitize_string(res)
    with open(os.path.join(h.base_dir, "store.dart"), "w") as f:
        f.write(res)


def write_main_page():
    res = "import 'package:flutter/material.dart';\nimport 'package:redux/redux.dart';\nimport 'package:flutter_redux/flutter_redux.dart';\nimport 'redux/store.dart';\n\n"
    res += "import 'config/keys.dart';\nimport 'config/route_generator.dart';\nimport 'redux/app/app_state.dart';\nimport 'redux/home/home_page.dart';\n"
    res += indented_line("void main() °")
    res += indented_line("WidgetsFlutterBinding.ensureInitialized();", 1)
    res += indented_line("runApp(MyApp());", 1)
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
    res = h.sanitize_string(res)
    with open(os.path.join(h.base_dir, "..", "main.dart"), "w") as f:
        f.write(res)


def write_config_pages():
    dir = h.config_dir
    os.makedirs(dir, exist_ok=True)
    res = "import 'package:flutter/material.dart';\n\n"
    res += "class Keys °"
    res += indented_line("static final scaffoldKey = GlobalKey<ScaffoldState>();", 1)
    res += indented_line("static final navigatorKey = GlobalKey<NavigatorState>();", 1)
    res += indented_line("#")
    res = h.sanitize_string(res)
    with open(os.path.join(dir, "keys.dart"), "w") as f:
        f.write(res)


"""
        
            
                
            
    }
  }
}

"""


def write_route_generator(params):
    def case_page(name):
        res = indented_line(f"case {name}.routeName:", 3)
        res += indented_line("return MaterialPageRoute(", 4)
        res += indented_line(
            f"builder: (_) => const {name}(), settings: settings);", 6)
        return res

    dir = h.config_dir
    os.makedirs(dir, exist_ok=True)
    res = "import 'package:flutter/material.dart';\n"
    res += "\n".join(
        [f"import '../redux/{param['name'].replace('State', '')}/{param['name'].replace('State', '')}_page.dart';" for param in params])
    res += "\n\nclass RouteGenerator °"
    res += indented_line(
        "static Route<dynamic> generateRoute(RouteSettings settings) °", 1)
    res += indented_line("var args;", 2)
    res += indented_line("if (settings.arguments != null) °", 2)
    res += indented_line("args = settings.arguments as Map<String, dynamic>;", 3)
    res += indented_line("#\n", 2)
    res += indented_line("switch (settings.name) °", 2)
    res += "\n".join([case_page(p["type"].replace("State", "Page"))
                     for p in params])
    res += indented_line("default:", 3)
    res += indented_line("// If there is no such named route in the switch statement", 4)
    res += indented_line("return MaterialPageRoute(", 4)
    res += indented_line("builder: (_) =>", 5)
    res += indented_line(
        "const Scaffold(body: SafeArea(child: Center(child: Text('Route Error')))),", 5)
    res += indented_line("settings: settings);", 5)
    res += indented_line("#", 3)
    res += indented_line("#", 2)
    res += indented_line("#", 1)

    res = h.sanitize_string(res)
    with open(os.path.join(dir, "route_generator.dart"), "w") as f:
        f.write(res)
