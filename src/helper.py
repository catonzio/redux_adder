import os

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
    capital_name = name[0].upper() + name[1:]
    return f"Update{state_name}{capital_name}Action"


def print_header(inp, size=50):
    print("\n#" + '-' * size + "#")
    spacing = int(((size+2)/2 - len(inp)/2))
    print(" " * spacing + inp + "\n")


def write_pages(component_name, pages):
    for page, post in pages:
        path = "outputs"  # os.path.join('lib', 'redux', value[2])
        os.makedirs(path, exist_ok=True)
        file_path = os.path.join(path, f'{component_name}_{post}')
        with open(file_path, 'w') as f:
            print(f"\nWriting {post} part.")
            f.write(page)


if __name__ == "__main__":
    pass
    # print_header("Creatingaaaaaaaaaaaaaaa")
    # orig = "prova_a_prendermi"
    # snake = camel_to_snake(orig)
    # camel = snake_to_camel(orig)
    # print(
    #     f"Orig: {orig}\nSnake: {snake}\nCamel: {camel}\nChange: {change_case(orig)}")
