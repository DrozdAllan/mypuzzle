import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  static const routeName = '/about';

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  static const String _url = 'https://allandrozd.com';
  static const String _animCredit = 'https://lottiefiles.com/user/284169';

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 54.0),
        child: Text(
          "About this app",
          style: isMobile
              ? Theme.of(context).textTheme.headline6
              : Theme.of(context).textTheme.headline1,
        ),
      ),
      Expanded(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "This app is made by ",
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
            children: <TextSpan>[
              TextSpan(
                  text: 'Allan Drozd',
                  style: const TextStyle(
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, -2), color: Colors.white)
                    ],
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(_url);
                    }),
              const TextSpan(
                  text: ' for the Flutter Hackaton of March 2022 \n\n'),
              const TextSpan(text: 'Confettis animations by '),
              TextSpan(
                  text: 'Zandre Coetzer',
                  style: const TextStyle(
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, -2), color: Colors.white)
                    ],
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(_animCredit);
                    }),
            ],
          ),
        ),
      ),
    ]);
  }
}
