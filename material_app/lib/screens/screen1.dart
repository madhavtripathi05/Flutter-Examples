import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'screen2.dart';

class Screen1 extends StatelessWidget {
  static const routeName = '/screen1';

  final String data;
  //initialing data obtained from previous screen
  Screen1({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Screen 1\ndata: $data'),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to Home Screen'),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to screen 2'),
              // directly replace with specified location
              // now you won't be able to get back to this screen
              onPressed: () => Navigator.pushReplacementNamed(
                  context, Screen2.routeName,
                  arguments: 'Hii from Screen 1'),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to Previous screen'),
              //getting back to previous screen
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
