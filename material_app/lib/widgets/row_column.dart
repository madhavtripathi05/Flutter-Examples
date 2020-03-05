import 'package:flutter/material.dart';

class RowColumn extends StatefulWidget {
  static const routeName = '/row-column';
  @override
  RowColumnState createState() => RowColumnState();
}

class RowColumnState extends State<RowColumn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Row and Column'), centerTitle: true),
      body: Center(
        child: Card(
          child: Column(
              //spaces between all the children will be same
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                    children: [
                      CircleAvatar(
                          child: Image.asset('assets/images/user.png',
                              width: 40, height: 40),
                          radius: 30),
                      Text('John Doe', style: TextStyle(fontSize: 30)),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                Text('Phone Number: 1234567890',
                    style: TextStyle(fontSize: 20)),
                Text('Address: 221B Baker Street',
                    style: TextStyle(fontSize: 20)),
                Text('Designation: SDE2', style: TextStyle(fontSize: 20)),
              ]),
          elevation: 10,
          margin: EdgeInsets.only(top: 200, right: 50, bottom: 200, left: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
