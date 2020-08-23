import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/test-screen';
  @override
  _TestScreenState createState() => _TestScreenState();
}

class NameValidator {
  static String validate(String val) {
    return val.isEmpty || val.length < 3 ? 'Enter a valid name' : null;
  }
}

class _TestScreenState extends State<TestScreen> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Title')),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() => name = val);
                },
                validator: NameValidator.validate,
              ),
              name != ''
                  ? Text('My Name is $name', key: Key('TextWidget'))
                  : Text('Enter a valid name!'),
            ],
          ),
        ),
      ),
    );
  }
}
