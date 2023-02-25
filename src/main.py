import argparse
import handle_actions as ha


def main(args):
    if args.action == "new":
        ha.new_redux_component(args.file, args.directory)
    elif args.action == "refresh":
        ha.refresh_redux_component(args.file, args.directory)


def handle_arguments():
    default_args = ['new', "-f", "inputs/prova.json"]

    parser = argparse.ArgumentParser(
        description="Project for modifying or adding redux components in flutter.")
    parser.add_argument("-f", "--file", dest="file",
                        help="the relative path of the scheleton file of the model")
    parser.add_argument("-d", "--d", dest="directory",
                        help="the relative path of the directory where multiple scheletons are located")
    parser.add_argument("action", choices=[
                        "new", "refresh"], help="The action to perform")

    return parser.parse_args(default_args)


if __name__ == "__main__":
    args = handle_arguments()
    print(args)
    main(args)
