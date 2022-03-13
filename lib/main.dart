import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mypuzzle/database/hive_db.dart';
import 'package:mypuzzle/screens/wrapper.dart';
import 'package:mypuzzle/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveDb.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allan Drozd Flutter Hackaton',
      theme: myTheme,
      home: const Wrapper(),
      onUnknownRoute: (context) => MaterialPageRoute(
        builder: (context) => const UnknownRoute(),
      ),
    );
  }
}

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Woops ! This route does not exist'),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/'),
            child: const Text('Return to home'),
          ),
        ]),
      ),
    );
  }
}
