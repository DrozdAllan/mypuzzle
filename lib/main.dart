import 'package:flutter/material.dart';
import 'package:mypuzzle/screens/home.dart';
import 'package:mypuzzle/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      onGenerateRoute: (RouteSettings settings) =>
          MyRouter.generateRoutes(settings),
      initialRoute: Home.routeName,
    );
  }
}

class MyRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName: // '/'
        return MaterialPageRoute(builder: (context) => const Home());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
