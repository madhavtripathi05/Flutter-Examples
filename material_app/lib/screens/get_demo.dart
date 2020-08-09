import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_app/controllers/product_controller.dart';
import '../controllers/my_controller.dart';
import '../constants.dart';
import './get_screen.dart';

/*
 * Multiple Ways to use Get State Manager:
 * by initializing controller using Get.put()
 * by using init inside GetBuilder()
 * by using Get.find()
 */
class GetDemo extends StatelessWidget {
  //* Initialize controller to use inside any widget
  final MyController myController = Get.put(MyController());

  static const routeName = '/get-demo';
  final ProductController productController = Get.find<ProductController>();
  void misc() {
    //* Some Misc things present in GetUtils
    GetUtils.capitalizeFirst('get');
    GetUtils.isPhoneNumber('9123456789');
    GetUtils.isHTML('<html></html>');
    //* and much more...
  }

  @override
  Widget build(BuildContext context) {
    var results;
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                  //* call methods available in MyController
                  onPressed: () => myController.increment(),
                  icon: Icon(Icons.add, color: Colors.green),
                  textColor: Colors.green,
                  label: Text('Add'),
                ),

                //* re-builds whenever update() is called
                GetBuilder<MyController>(
                    //* if you're just using MyController in this
                    //* particular widget you can use init:
                    init: MyController(),
                    builder: (_) {
                      return Text('Count: ${_.count}');
                    }),

                FlatButton.icon(
                    //* Get will search for MyController in RAM
                    onPressed: () => Get.find<MyController>().decrement(),
                    icon: Icon(Icons.remove, color: Colors.red),
                    textColor: Colors.red,
                    label: Text('Sub'))
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* if you just want to translate w/o any args
                // Text('greeting'.tr),
                //* pass Arguments easily
                Text(
                  'greeting'.trArgs(['John']),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                DropdownButton<String>(
                  value: Get.locale.toString(),
                  items: <String>['en_US', 'en_IN', 'hn_IN', 'gj_IN']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {
                    switch (_) {
                      case 'hn_IN':
                        //* updating local translations
                        Get.updateLocale(Locale('hn', 'IN'));
                        break;
                      case 'gj_IN':
                        Get.updateLocale(Locale('gj', 'IN'));
                        break;
                      case 'en_IN':
                        Get.updateLocale(Locale('en', 'IN'));
                        break;
                      case 'en_US':
                        Get.updateLocale(Locale('en', 'US'));
                        break;
                      default:
                        Get.updateLocale(Locale('en', 'US'));
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('Snackbar(Get)'),
                  textColor: Colors.redAccent,
                  onPressed: () =>
                      //* Using Get Snackbar
                      Get.snackbar('Title', 'This is Get Snackbar!'),
                ),
                FlatButton(
                  child: Text('Snackbar(Default)'),
                  textColor: Colors.greenAccent,
                  onPressed: () =>
                      //* Using Default Snackbar
                      Get.rawSnackbar(
                          title: 'Title',
                          message: 'This is your default Snackbar'),
                ),
                FlatButton(
                  child: Text('Open Dialog'),
                  textColor: Colors.blueAccent,
                  onPressed: () =>
                      //* Opening Dialogs
                      Get.defaultDialog(
                    title: 'Do you like GET?',
                    content: Text('This is a Dialog'),
                    textConfirm: 'okay',
                    confirmTextColor: Colors.white,
                    onConfirm: () => Get.back(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('BottomSheet'),
                  textColor: Colors.purpleAccent,
                  onPressed: () =>
                      //* Open BottomSheet
                      Get.bottomSheet(
                    Container(
                        height: 150,
                        color: Colors.grey[600],
                        child: Center(child: Text('This is a BottomSheet'))),
                  ),
                ),
                FlatButton(
                    textColor: Colors.blueGrey,
                    child: Text('Next Screen'),
                    onPressed: () async {
                      //* simply replace Navigator.push() with Get.to()
                      // Get.to(GetScreen());

                      //* Using Named Routes
                      //* when the next screen is closed and if you
                      //* want some data back you can do:
                      results = await Get.toNamed(GetScreen.routeName,
                          arguments: 'some data');
                      print(results);

                      //* Alternative to Navigator.pushReplacement()
                      // Get.off(GetScreen());

                      //* Similarly for Navigator.popUntil()
                      //* & pushReplacementAndUntil()
                      // Get.until((route) => false);
                      // Get.offAll(GetScreen());

                      //* also if you don't want to remember Gets' Syntax
                      //* just replace 'Navigator' with 'navigator' i.e.
                      // navigator.pushNamed('/get-screen');
                    }),
                FlatButton(
                  child: Text('Change Theme'),
                  onPressed: () => Get.changeTheme(
                      Get.isDarkMode ? kLightTheme : kDarkTheme),
                ),
              ],
            ),
            Text(
                'Screen Height: ${Get.height.round()} px, Width: ${Get.width.round()} px'),
            Text('isAndroid: ${GetPlatform.isAndroid}'),
            SizedBox(height: 20),

            //* Lightweight GetX, w/o init(consumes less memory)
            Obx(
              () => Column(
                children: [
                  Text(
                    'Product Title: ${productController.product.value.title}',
                    style: kBoldText,
                  ),
                  Text(
                    'Product Price: ${productController.product.value.price}',
                    style: kBoldText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* Get helps you to significantly reduce your app development 
* time by providing all this useful features in one package.
* There are lot more options than the one I've mentioned here.
* Go checkout their full documentation for more info. In upcoming
* posts we'll see how we can use GetX State Manager and Reactive 
* State Manager which is based on Streams also how to inject 
* Controllers during runtime using lazyLoading them.
*/
