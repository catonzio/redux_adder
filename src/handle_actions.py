
import os
from helper import change_case, print_header

from pages.action_page import ActionPage
from pages.middleware_page import MiddlewarePage
from pages.reducer_page import ReducerPage
from pages.state_page import StatePage
from pages.view_model_page import ViewModelPage


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

    return params


def new_redux_component():
    print_header("Creating new component")

    component_name = input("Insert the name of the component (snake_case): ")
    params = get_params_from_user()

    camel_case = change_case(component_name)
    camel_case = camel_case[0].upper() + camel_case[1:]

    state_page = StatePage(camel_case, params).build_page()
    vm_page = ViewModelPage(camel_case).build_page()
    reducer_page = ReducerPage(camel_case, params).build_page()
    middleware_page = MiddlewarePage(camel_case).build_page()
    action_page = ActionPage(camel_case, params).build_page()

    pages = [[state_page, "state"], [vm_page, 'vm'],
             [reducer_page, 'reducer'], [middleware_page, 'middleware'], [action_page, 'action']]

    for page, post in pages:
        path = "outputs"  # os.path.join('lib', 'redux', value[2])
        os.makedirs(path, exist_ok=True)
        file_path = os.path.join(path, f'{component_name}_{post}.dart')
        with open(file_path, 'w') as f:
            print(f"\nWriting {post} part.")
            f.write(page)


def add_parameter_to_component():
    print_header("Adding new parameter")


    component_name = input("Insert the name of the component (snake_case): ")
    params = get_params_from_user()

    camel_case = change_case(component_name)
    camel_case = camel_case[0].upper() + camel_case[1:]


def remove_parameter_from_component():
    print_header("Removing parameter")

    component_name = input("Insert the name of the component (snake_case): ")
    params = get_params_from_user()

    camel_case = change_case(component_name)
    camel_case = camel_case[0].upper() + camel_case[1:]


if __name__ == "__main__":
    new_redux_component()
