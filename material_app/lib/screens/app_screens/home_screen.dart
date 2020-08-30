import 'package:flutter/material.dart';
import 'screen1.dart';
import 'screen2.dart';

class HomeScreen extends StatelessWidget {
  /* this is optional, alternatively you can specify String
     directly in Routes Table*/
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Home Screen'),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to screen 1'),
              //there are two methods
              //1) using Navigator.push()
              onPressed: () => Navigator.push(
                  context,
                  //suppose you want to initialize data present on another screen.
                  MaterialPageRoute(
                    builder: (context) => Screen1(
                      data: 'Hii from HomeScreen',
                    ),
                  )),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Move to screen 2'),
              //2) directly specify the name of Screen from Route Table
              onPressed: () => Navigator.pushNamed(context, Screen2.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
