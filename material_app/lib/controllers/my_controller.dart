import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyController extends GetxController {
  final _text = ''.obs;
  final _count = 0.obs;
  SharedPreferences prefs;

  int get count => this._count.value;
  set count(value) => this._count.value = value;

  String get text => this._text.value;
  set text(value) => this._text.value = value;

  increment() {
    count++;
    //* for updating in UI
    update();
  }

  decrement() {
    count--;
    update();
  }

  updateText(String data) {
    text = data;
    update();
    prefs.setString('data', data);
  }

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    text = prefs.getString('data') ?? '!';
    super.onInit();
  }
}
