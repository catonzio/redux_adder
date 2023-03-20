import 'package:flutter/material.dart';
import '../redux/home/home_page.dart';

class RouteGenerator {
	static Route<dynamic> generateRoute(RouteSettings settings) {
		var args;
		if (settings.arguments != null) {
			args = settings.arguments as Map<String, dynamic>;
		}

		switch (settings.name) {
			case HomePage.routeName:
				return MaterialPageRoute(
						builder: (_) => const HomePage(), settings: settings);
			default:
				// If there is no such named route in the switch statement
				return MaterialPageRoute(
					builder: (_) =>
					const Scaffold(body: SafeArea(child: Center(child: Text('Route Error')))),
					settings: settings);
			}
		}
	}