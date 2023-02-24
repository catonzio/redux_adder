import argparse
import handle_actions as ha


def main(args):
    if args.action == "new":
        ha.new_redux_component(args.file)
    elif args.action == "add":
        ha.add_parameter_to_component()
    elif args.action == "remove":
        ha.remove_parameter_from_component()


if __name__ == "__main__":
    default_args = ['new', "--file", "inputs/prova.json"]

    parser = argparse.ArgumentParser(
        description="Project for modifying or adding redux components in flutter.")
    parser.add_argument("-f", "--file", dest="file", help="the relative path of the scheleton file of the model")
    parser.add_argument("action", choices=[
                        "new", "add", "remove"], help="The action to perform")

    args = parser.parse_args(default_args)
    main(args)
