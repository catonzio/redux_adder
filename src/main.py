import argparse
import handle_actions as ha


def main(args):
    if args.action == "new":
        ha.new_redux_component()
    elif args.action == "add":
        ha.add_parameter_to_component()
    elif args.action == "remove":
        ha.remove_parameter_from_component()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Project for modifying or adding redux components in flutter.")
    parser.add_argument("action", choices=[
                        "new", "add", "remove"], help="The action to perform")
    args = parser.parse_args()
    main(args)
