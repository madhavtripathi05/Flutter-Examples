import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/screen1.dart';
import './screens/screen2.dart';

import './widgets/buttons_demo.dart';
import './widgets/row_column.dart';
import './widgets/scaffold_widget.dart';
import './widgets/sliders_demo.dart';
import './widgets/stack_widget.dart';

//as every programming language execution starts from main()
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //for hiding that debug logo on top
      debugShowCheckedModeBanner: false,

      //title of your app
      title: 'Sample App',

      //theme:
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: 'google'),

      //our app will be loaded from here
      home: ScaffoldWidget(),

      //routes to different screens
      routes: {
        /*if home not specified app will start from here*/
        ButtonsDemo.routeName: (context) => ButtonsDemo(),
        HomeScreen.routeName: (context) => HomeScreen(),
        RowColumn.routeName: (context) => RowColumn(),
        ScaffoldWidget.routeName: (context) => ScaffoldWidget(),
        Screen1.routeName: (context) => Screen1(),
        Screen2.routeName: (context) => Screen2(),
        SlidersDemo.routeName: (context) => SlidersDemo(),
        StackWidget.routeName: (context) => StackWidget(),
      },
    );
  }
}
