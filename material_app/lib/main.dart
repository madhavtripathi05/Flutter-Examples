import 'package:flutter/material.dart';

import './widgets/row_column.dart';
import './widgets/scaffold_widget.dart';

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
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Color(0xff),
      ),

      //our app will be loaded from here
      home: ScaffoldWidget(),

      //routes to different screens
      routes: {
        /*if home not specified app will start from here*/
        ScaffoldWidget.routeName: (context) => ScaffoldWidget(),
        RowColumn.routeName: (context) => RowColumn(),
      },
    );
  }
}
