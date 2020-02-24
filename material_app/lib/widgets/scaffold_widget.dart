import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('This is sample app'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('button pressed'),
      ),
    );
  }
}
