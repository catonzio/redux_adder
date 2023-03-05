
import json
import os
import helper
from helper import get_folder_components, print_header
from write_default_pages import *   


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
    os.makedirs(helper.base_dir, exist_ok=True)
    make_homepage_component()
    params = get_folder_components()
    make_app_component(params)
    create_store_page(params)
    write_main_page()
    write_config_pages()
    write_route_generator(params)
    print("\nUse the following commands to install the needed packages:")
    print("\tflutter pub add flutter_redux\t(https://pub.dev/packages/flutter_redux)")
    print("\tflutter pub add redux\t\t(https://pub.dev/packages/redux)")
    print("Have a nice day 😊")


if __name__ == "__main__":
    # new_redux_component()
    write_main_page()
