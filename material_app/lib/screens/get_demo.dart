import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import './get_screen.dart';

class GetDemo extends StatelessWidget {
  static const routeName = '/get-demo';
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
                  child: Text('Open BottomSheet'),
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
                      results = await Get.toNamed('/get-screen',
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
