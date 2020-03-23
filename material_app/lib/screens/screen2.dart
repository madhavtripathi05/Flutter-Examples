import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'screen1.dart';

class Screen2 extends StatelessWidget {
  static const routeName = '/screen2';
  @override
  Widget build(BuildContext context) {
    String argsData;
    final args = ModalRoute.of(context).settings.arguments;
    argsData = args.toString();

    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Screen 2' + '\nArgs Data: $argsData'),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to Home Screen'),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to screen 1'),
              onPressed: () => Navigator.pushNamed(context, Screen1.routeName),
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text('Move to Previous screen'),
                /* this will directly take you to HomeScreen,
                reason: we used pushReplacement from Screen1*/
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
