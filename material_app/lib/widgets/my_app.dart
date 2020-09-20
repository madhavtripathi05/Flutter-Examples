import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_app/routes.dart';

import '../constants.dart';
import '../controllers/bindings/product_bind.dart';
import '../screens/screens.dart';
import '../services/analytics_service.dart';
import '../utils/translations.dart';

// just like every programming language, execution starts from main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //* Instead of MaterialApp return GetMaterialApp
    //* Also if you're using Get just for managing states,
    //* You don't need to use GetMaterialApp()
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

      //* you can also set initial
      //* binding in GetMaterialApp
      initialBinding: ProductBind(),

      //* Page Transition Animation.
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),

      //* routes to different screens.
      getPages: AppRoutes.routes,

      //* Inside Material App add this line to observe pages.
      navigatorObservers: <NavigatorObserver>[AnalyticsService().observer],

      //* do something when a particular route is called.
      routingCallback: (routing) {
        routing.current == '/scaffold-widget'
            ? print('Home Screen')
            : print(routing.current);
      },
    );
  }
}
