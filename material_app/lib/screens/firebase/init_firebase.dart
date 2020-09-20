import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_app/widgets/my_app.dart';

class InitFirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return MaterialApp(
              home: Center(child: Text('Error:${snapshot.error}')));

        if (snapshot.connectionState == ConnectionState.done) return MyApp();

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
