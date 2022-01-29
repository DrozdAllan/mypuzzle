import 'package:flutter/material.dart';
import 'package:mypuzzle/models/user_id.dart';

class Reception extends StatefulWidget {
  const Reception({Key? key}) : super(key: key);

  static const routeName = '/reception';

  @override
  _ReceptionState createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserID;

    return Scaffold(
      appBar: AppBar(),
      body: Text('the argument is ' + args.id),
    );
  }
}
