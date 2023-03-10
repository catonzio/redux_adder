import argparse
import handle_actions as ha
from pages.widget_page import WidgetPage
from helper import update_base_dir
import os


def main(args):
    if args.action == "new":
        ha.new_redux_component(args.file, args.directory)
    elif args.action == "refresh":
        ha.refresh_redux_component(args.file, args.directory)
    elif args.action == "init":
        ha.init_project()


def handle_arguments():
    default_args = ['new', "-d", "inputs"]
    # default_args = ['new', "-f", "inputs/prova2.json"]
    default_args = ["init", "libr"]

    parser = argparse.ArgumentParser(
        description="Project for modifying or adding redux components in flutter.")
    parser.add_argument("-f", "--file", dest="file",
                        help="the relative path of the scheleton file of the model")
    parser.add_argument("-d", "--d", dest="directory",
                        help="the relative path of the directory where multiple scheletons are located")
    parser.add_argument("action", choices=[
                        "new", "refresh", "init"], help="The action to perform")
    parser.add_argument(
        "dest", help="The path of the base folder used by the program", default="redux_adder")
    # return parser.parse_args(default_args)
    return parser.parse_args()


if __name__ == "__main__":
    args = handle_arguments()
    update_base_dir(args.dest)
    main(args)
