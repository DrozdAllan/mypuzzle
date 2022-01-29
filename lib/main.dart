import 'package:flutter/material.dart';
import 'package:mypuzzle/screens/home.dart';
import 'package:mypuzzle/screens/reception.dart';
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
      initialRoute: Home.routeName,
      routes: myRoutes,
      onUnknownRoute: (context) => MaterialPageRoute(
        builder: (context) => const UnknownRoute(),
      ),
    );
  }
}

Map<String, WidgetBuilder> myRoutes = {
  Home.routeName: (context) => const Home(),
  Reception.routeName: (context) => const Reception(),
};

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Woops ! This route does not exist'),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Home.routeName),
            child: const Text('Return to home'),
          ),
        ]),
      ),
    );
  }
}
