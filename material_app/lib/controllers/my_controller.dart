import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* Get has Two types of State manager
* 1) similar to ChangeNotifier, which updates the sate when update() is called
* 2) Reactive: Similar to Bloc, based on streams 
*/

//* Controllers are used to control state of your app

class MyController extends GetxController {
  //* Normal variable
  int count = 0;

  increment() {
    count++;
    //* for updating in UI
    update();
  }

  decrement() {
    count--;
    //* similar to calling notifyListeners()
    update();
  }
}
