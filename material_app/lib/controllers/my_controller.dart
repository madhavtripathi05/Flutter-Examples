import 'package:get/get.dart';

/*
* Get has Two types of State manager.
* 1) Simple: similar to ChangeNotifier, which updates the
* state whenever update() is called.
* 2) Reactive: Similar to Bloc, based on streams (next post)
*/

class MyController extends GetxController {
//* Controllers are used to control state of your app

  //* Normal variable
  int count = 0;

  increment() {
    count++;
    //* for updating the UI
    update();
  }

  decrement() {
    count--;
    //* similar to calling notifyListeners()
    update();
  }
}
