import 'package:flutter/material.dart';

class FormsDemo extends StatefulWidget {
  static const routeName = '/forms';
  @override
  _FormsDemoState createState() => _FormsDemoState();
}

class _FormsDemoState extends State<FormsDemo> {
  // helper variables and methods
  String name = '';
  String email = '';
  String password = '';

  // this will be used to validate our form.
  final _formKey = GlobalKey<FormState>();
  final pad = EdgeInsets.all(8);

  // when we press submit button
  submit() {
    // getting current values of form
    final form = _formKey.currentState;
    // checking if form is valid
    if (form.validate()) {
      // clear all fields
      form.reset();
      // print in console
      print('Name:$name\nEmail:$email\npassword:$password');
    } else
      print('invalid form');
  }

  // decoration around TextField and labels
  InputDecoration decor(label, hint) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelText: label,
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms Demo'),
      ),
      body: Form(
        // assign the formKey
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: pad,
              child: TextFormField(
                // when form opens this field will be focused.
                autofocus: true,
                decoration:
                    decor('Name', 'Enter your name (at least 3 characters)'),
                // assign value to that specific field
                onChanged: (value) => name = value,
                validator: (val) =>
                    val.length < 3 ? 'Enter 3 characters' : null,
              ),
            ),
            Padding(
              padding: pad,
              child: TextFormField(
                decoration: decor('Email', 'Enter your email'),
                onChanged: (value) => email = value,
                // validating email 
                validator: (val) =>
                    (val.length < 6 && !val.contains('@') && !val.contains('.'))
                        ? 'invalid Email'
                        : null,
              ),
            ),
            Padding(
              padding: pad,
              child: TextFormField(
                decoration: decor(
                    'Password', 'Enter a password (at least 6 characters)'),
                onChanged: (value) => password = value,
                // hiding the text as it's a password
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter 6 characters' : null,
              ),
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              // give a reference to previously defined method
              onPressed: submit,
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
