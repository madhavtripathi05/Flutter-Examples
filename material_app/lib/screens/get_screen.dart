import 'package:flutter/material.dart';
import '../controllers/my_controller.dart';
import 'package:get/get.dart';

class GetScreen extends StatelessWidget {
  static const routeName = '/get-screen';
  @override
  Widget build(BuildContext context) {
    //* WillPopScope is used to handle Back Button
    return WillPopScope(
      onWillPop: () {
        //* Instead of Navigator.pop use Get.back()
        Get.back(result: 'results'); // send results to prev screen
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('MyPage')),
        body: Container(
          child: GetX<MyController>(
              init: MyController(), // no need if you're using bindings
              builder: (_) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* Getting Data from prev screen
                    Text('data form Previous Screen: ${Get.arguments}'),
                    Text('${_.text}'),
                  ],
                ));
              }),
        ),
      ),
    );
  }
}
