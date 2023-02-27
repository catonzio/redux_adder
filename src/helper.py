import os

BASE_DIR = "outputs/redux"


def indented_line(s, level=0):
    return "\n" + "\t"*level + s


def camel_to_snake(str):
    return ''.join(['_'+i.lower() if i.isupper()
                    else i for i in str]).lstrip('_')


def snake_to_camel(str):
    components = str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])


def change_case(str):
    return snake_to_camel(str) if "_" in str else camel_to_snake(str)


def get_snake_action_name(action_name):
    return "_" + action_name[0].lower() + action_name[1:]


def get_action_from_name(name, state_name):
    capital_name = capitalize(name)
    return f"Update{state_name}{capital_name}Action"


def capitalize(s):
    return s[0].upper() + s[1:]


def uncapitalize(s):
    return s[0].lower() + s[1:]


def print_header(inp, size=50):
    print("\n#" + '-' * size + "#")
    spacing = int(((size+2)/2 - len(inp)/2))
    print(" " * spacing + inp + "\n")


def write_pages(component_name, pages, dir=BASE_DIR):
    print_header(component_name)
    for page, post in pages:
        # os.path.join('lib', 'redux', value[2])
        path = os.path.join(dir, component_name)
        os.makedirs(path, exist_ok=True)
        file_path = os.path.join(path, f'{component_name}_{post}')
        with open(file_path, 'w') as f:
            print(f"Writing {post} in {file_path}")
            f.write(page)


if __name__ == "__main__":
    pass
    # print_header("Creatingaaaaaaaaaaaaaaa")
    # orig = "prova_a_prendermi"
    # snake = camel_to_snake(orig)
    # camel = snake_to_camel(orig)
    # print(
    #     f"Orig: {orig}\nSnake: {snake}\nCamel: {camel}\nChange: {change_case(orig)}")
