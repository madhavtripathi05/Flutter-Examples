import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_app/widgets/my_app.dart';

class InitFirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(child: Icon(FlutterIcons.error_mdi));

        if (snapshot.connectionState == ConnectionState.done) return MyApp();

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
