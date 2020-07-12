import 'package:flutter/material.dart';

import './screens/screens.dart';

import './widgets/widgets.dart';

// just like every programming language, execution starts from main()
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //for hiding that debug logo on top
      debugShowCheckedModeBanner: false,

      //title of your app
      title: 'Flutter Examples',

      // theme:
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: 'google'),

      // our app will be loaded from here
      home: ScaffoldWidget(),

      // routes to different screens
      routes: {
        /*if home not specified app will start from here*/
        AnimationsScreen.routeName: (context) => AnimationsScreen(),
        AsyncAwait.routeName: (context) => AsyncAwait(),
        AuthScreen.routeName: (context) => AuthScreen(),
        ButtonsDemo.routeName: (context) => ButtonsDemo(),
        BlocLogin.routeName: (context) => BlocLogin(),
        ConfirmationAcknowledgement.routeName: (context) =>
            ConfirmationAcknowledgement(),
        FormsDemo.routeName: (context) => FormsDemo(),
        GridViewBuilderDemo.routeName: (context) => GridViewBuilderDemo(),
        HomeScreen.routeName: (context) => HomeScreen(),
        HttpDemo.routeName: (context) => HttpDemo(),
        HandlingTaps.routeName: (context) => HandlingTaps(),
        ListViewBuilderDemo.routeName: (context) => ListViewBuilderDemo(),
        MapsScreen.routeName: (context) => MapsScreen(),
        NavigationRailDemo.routeName: (context) => NavigationRailDemo(),
        RowColumn.routeName: (context) => RowColumn(),
        ScaffoldWidget.routeName: (context) => ScaffoldWidget(),
        Screen1.routeName: (context) => Screen1(),
        Screen2.routeName: (context) => Screen2(),
        SharedPrefsDemo.routeName: (context) => SharedPrefsDemo(),
        StreamDemo.routeName: (context) => StreamDemo(),
        SlidersDemo.routeName: (context) => SlidersDemo(),
        TodoScreen.routeName: (context) => TodoScreen(),
        StackWidget.routeName: (context) => StackWidget(),
        TabBarDemo.routeName: (context) => TabBarDemo()
      },
    );
  }
}
