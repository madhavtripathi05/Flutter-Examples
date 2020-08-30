import 'package:flutter/material.dart';
import './screens/firebase/init_firebase.dart';

void main() {
  //* For binding our app to Firebase:
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitFirebaseApp());
}
