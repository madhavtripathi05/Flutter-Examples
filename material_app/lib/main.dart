import 'package:flutter/material.dart';
import 'package:material_app/routes.dart';

import './widgets/widgets.dart';
import './utils/translations.dart';
import 'constants.dart';
import 'package:get/get.dart';
import 'package:dartx/dartx.dart';

// just like every programming language, execution starts from main()
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instead of MaterialApp return GetMaterialApp
    return GetMaterialApp(
      //for hiding that debug logo on top
      debugShowCheckedModeBanner: false,

      //title of your app
      title: 'Flutter Examples',

      // theme:
      theme: kLightTheme,

      // our app will be loaded from here
      initialRoute: ScaffoldWidget.routeName,
      //* Internationalize your apps easily!
      locale: Locale('en', 'US'),
      translations: AppTranslations(),

      //* Page Transition Animation.
      defaultTransition: Transition.fadeIn,
      transitionDuration: 500.milliseconds,

      //* routes to different screens.
      getPages: AppRoutes.routes,

      //* do something when a particular route is called.
      routingCallback: (routing) {
        routing.current == '/scaffold-widget'
            ? print('Home Screen')
            : print(routing.current);
      },
    );
  }
}
