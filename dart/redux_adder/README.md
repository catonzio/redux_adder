Redux Adder
===========

Redux Adder is a Dart plugin that allows you to generate components for the [Redux library](https://pub.dev/packages/flutter_redux) used in a Flutter project to manage the state of the app. With Redux Adder, you can quickly create new Redux components without having to write all the boilerplate code yourself.

Installation
------------

To use Redux Adder, you must have Dart and Flutter installed on your machine. Once you have [Dart](https://dart.dev/get-dart) or [Flutter](https://docs.flutter.dev/get-started/install?gclid=CjwKCAjwiOCgBhAgEiwAjv5whPWe8ZUTUqG-jQ0INp6KgtDKFkemciUK3AOqAGcdPp5jEvtGgZyt3xoCsREQAvD_BwE&gclsrc=aw.ds) installed, you can install Redux Adder using the following command:

```
pub global activate redux_adder
```

Alternatively, you can also install Redux Adder using the following command:

```
flutter pub global activate redux_adder
```

Idea
--------

The idea behind this project is that the Redux library for Flutter is fantastic when it comes to state management, but by its nature, it is very difficult to maintain and evolve.

For this reason, it would be great to be able to manage the state, actions, reducers, and view model with a single easily maintainable JSON file. And with this plugin, the dream becomes true.

The skeleton of a JSON component is the following:
```json
{
	"name": "name_of_the_component",
	"parameters": [
		{
			"type": "int|bool|DateTime|OtherComponent|...",
			"name": "nameOfParameter",
			"is_comp": false
		},
		{
			"type": "List<int>",
			"name": "myList",
			"is_comp": false
		},
		{
			"type": "String",
			"name": "stringParam",
			"is_comp": false
		},
		{
			"type": "OtherState",
			"name": "other",
			"is_comp": true
		}
	],
	"actions": [
		{
			"name": "NameOfTheAction",
			"parameters": [
				{
					"type": "int|bool|DateTime|OtherComponent|...",
					"name": "nameOfParameter",
					"is_comp": false
				}
			],
			"implementation": "return state.copyWith(\n\t\tnameOfParameter: action.nameOfParameter,\n\t);",
			"async": false
		}
	]
}
```


Commands
--------

Redux Adder comes with several commands that you can use to generate Redux components. These commands include:

### init

The `init` command initializes your Flutter project for use with Redux. You only need to run this command once per project.

```
Usage: redux_adder init [arguments]
-h, --help               Print this usage information.
-d, --directory=<lib>    the (relative) directory in which initialize the app
                         (defaults to "lib/redux")
```

### new

The `new` command creates a new Redux component. You can create a new Redux component by running the following command:

```
Usage: redux_adder new [arguments]
-h, --help                              Print this usage information.
-d, --directory=<path/to/directory>     The (relative) directory from which to take component skeletons
-f, --file=<path/to/file.json>          The (relative) file from which to take component skeleton
-o, --output=<path/to/output/folder>    The (relative) directory in which save the new component
```

### delete

The `delete` command deletes an existing Redux component. You can delete an existing Redux component by running the following command:

```
Usage: redux_adder delete [arguments]
-h, --help                                                   Print this usage information.
-d, --directory=<path/to/component/directory> (mandatory)    The (relative) directory of the component to delete
-y, --[no-]yes                                               Flag to determine if delete directly or not
```

Conclusion
----------

Redux Adder is a useful tool for creating and managing Redux components in your Flutter project. With its simple and easy-to-use commands, you can quickly generate new Redux components and keep your project organized. If you have any issues or questions, please feel free to reach out to the Redux Adder community.