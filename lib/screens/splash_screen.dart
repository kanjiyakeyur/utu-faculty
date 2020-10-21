import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pink, Colors.indigo],
  ).createShader(Rect.fromLTWH(135.0, 0.0, 130.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '   Fetching details ... ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient,
            ),
          ),
          //Container(
          //  width: MediaQuery.of(context).size.width * 0.75,
          //  child: LinearProgressIndicator(
          //    minHeight: 2,
          //    backgroundColor: Colors.pink,
          //  ),
          //),
        ],
      ),
    ));
  }
}
