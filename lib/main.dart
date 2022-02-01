import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:mypuzzle/screens/home.dart';
import 'package:mypuzzle/screens/reception.dart';
import 'package:mypuzzle/theme.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
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
