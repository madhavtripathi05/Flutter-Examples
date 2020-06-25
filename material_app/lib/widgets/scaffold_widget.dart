import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_app/bloc/my_provider.dart';
import 'package:material_app/screens/animations_screen.dart';
import 'package:material_app/screens/todo_screen.dart';
import '../screens/bloc_login.dart';
import '../screens/confirmation_acknowledgement.dart';
import '../screens/home_screen.dart';
import '../widgets/async_await.dart';
import '../widgets/handling_taps.dart';
import '../widgets/http_demo.dart';
import '../widgets/shared_prefs_demo.dart';
import '../widgets/stream_demo.dart';
import '../widgets/tab_bar.dart';
import '../widgets/form_demo.dart';
import '../widgets/sliders_demo.dart';
import '../widgets/stack_widget.dart';
import '../widgets/buttons_demo.dart';
import 'gridview_builder.dart';
import 'listview_builder.dart';
import 'navigation_rail_demo.dart';

class ScaffoldWidget extends StatefulWidget {
  static const routeName = '/scaffold-widget';
  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  Color myColor = Colors.blue;
  List<Color> colors = [
    Colors.green,
    Colors.pink,
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.orange,
    Colors.indigo,
    Colors.cyan,
  ];
  int counter = 0;
  int selectedIndex = 0;
  List<Map<String, String>> titles = [
    {'Navigation Rail Demo': NavigationRailDemo.routeName},
    {'Async/Await/Future': AsyncAwait.routeName},
    {'Confirmation &\nAcknowledgement': ConfirmationAcknowledgement.routeName},
    {'Shared Prefs Demo': SharedPrefsDemo.routeName},
    {'Navigation Demo': Navigator.defaultRouteName},
    {'Handling Taps': HandlingTaps.routeName},
    {'Stream Demo': StreamDemo.routeName},
    {'TabBar Demo': TabBarDemo.routeName},
    {'HTTP Demo': HttpDemo.routeName},
    {'Animations': AnimationsScreen.routeName},
    {'Bloc Login': BlocLogin.routeName},
    {'Todo App': TodoScreen.routeName},
    {'Listview': ListViewBuilderDemo.routeName},
    {'Gridview': GridViewBuilderDemo.routeName},
    {'Sliders': SlidersDemo.routeName},
    {'Buttons': ButtonsDemo.routeName},
    {'Stack': StackWidget.routeName},
    {'Form': FormsDemo.routeName},
  ];
  void changeColor() =>
      setState(() => myColor = colors[Random().nextInt(colors.length)]);
  void increment() => setState(() => counter++);
  void decrement() => setState(() => counter > 0 ? counter-- : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*top area of your app where you can provide different things like 
      title of app, set custom actions*/
      appBar: AppBar(
        title: Text(
            //this is a Text widget here you can use it to add text to your widget
            'Example App'),
        backgroundColor: myColor,
        centerTitle: true,
        actions: <Widget>[
          //this is present on the right side of appBar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var i = 0; i < titles.length; i++) ...[
                RaisedButton(
                  color: myColor,
                  textColor: Colors.white,
                  onPressed: () =>
                      Navigator.pushNamed(context, titles[i].values.first),
                  child: Text(
                    titles[i].keys.first,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            CircleAvatar(
                //adds a circular logo inside which you can add anything
                child: FlutterLogo(),
                backgroundColor: myColor),

            //adding multiple options
            for (var i = 1; i < 5; i++)
              ListTile(
                title: Text('Option $i'),
                leading: Icon(Icons.check_circle_outline, color: myColor),
                onTap: () =>
                    Navigator.pushNamed(context, StackWidget.routeName),
              ),
          ],
        ),
      ),
      endDrawer: Drawer(
        //this drawer will open when you will swipe from right side
        child: ListView(children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: myColor,
            child: Icon(Icons.account_circle, color: Colors.white),
          ),
          ListTile(
            title: Text('Name'),
          ),
          ListTile(
            title: Text('Account details'),
          ),
          ListTile(
            title: Text('Settings'),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        /*what should happen when we tap on button,
        here we're calling buttonTap method defined priorly*/
        onPressed: changeColor,
        tooltip: 'tap me to change color of appBar',
        child: Icon(Icons.refresh),
        backgroundColor: myColor,
      ),
      //add this when you want buttons in footer area like a send button in chat,
      persistentFooterButtons: <Widget>[
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              changeColor();
              decrement();
            },
            color: myColor),
        Text('$counter', style: TextStyle(color: myColor)),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              changeColor();
              increment();
            },
            color: myColor),
      ],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: myColor,
          onTap: (val) {
            setState(() => selectedIndex = val);
            changeColor();
          },
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
                title: Text('action 1'), icon: Icon(Icons.android)),
            BottomNavigationBarItem(
                title: Text('action 2'), icon: Icon(Icons.touch_app)),
            BottomNavigationBarItem(
                title: Text('action 3'), icon: Icon(Icons.work)),
            BottomNavigationBarItem(
                title: Text('action 4'), icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(
                title: Text('action 5'), icon: Icon(Icons.account_circle)),
          ]),
    );
  }
}
