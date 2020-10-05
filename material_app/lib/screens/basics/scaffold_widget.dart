import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_app/services/analytics_service.dart';

import '../screens.dart';

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
  bool view = false;
  List<Map<String, String>> titles = [
    {'Navigation Rail Demo': NavigationRailDemo.routeName},
    {'Async/Await/Future': AsyncAwait.routeName},
    {'Confirmation &\nAcknowledgement': ConfirmationAcknowledgement.routeName},
    {'Autocomplete Demo': AutoCompleteScreen.routeName},
    {'Shared Prefs Demo': SharedPrefsDemo.routeName},
    {'Navigation Demo': HomeScreen.routeName},
    {'Firestore Demo': StudentsList.routeName},
    {'Handling Taps': HandlingTaps.routeName},
    {'Firebase Auth': FirebaseAuthScreen.routeName},
    {'Stream Demo': StreamDemo.routeName},
    {'TabBar Demo': TabBarDemo.routeName},
    {'Google Maps': MapsScreen.routeName},
    {'HTTP Demo': HttpDemo.routeName},
    {'Auth Demo': AuthScreen.routeName},
    {'Animations': AnimationsScreen.routeName},
    {'Test Screen': TestScreen.routeName},
    {'Get Demo': GetDemo.routeName},
    {'Todo App': TodoScreen.routeName},
    {'Listview': ListViewBuilderDemo.routeName},
    {'Gridview': GridViewBuilderDemo.routeName},
    {'Sliders': SlidersDemo.routeName},
    {'Buttons': ButtonsDemo.routeName},
    {'Stack': StackWidget.routeName},
    {'Form': FormsDemo.routeName},
  ];
  void changeColor() => setState(() {
        myColor = colors[Random().nextInt(colors.length)];
        view = !view;
      });
  void increment() => setState(() => counter++);
  void decrement() => setState(() => counter > 0 ? counter-- : null);

  @override
  Widget build(BuildContext context) {
    //* Place this inside the 1st screen of your app:
    AnalyticsService().appOpen();

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
      body: view ? buildListView() : buildGridView(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
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
        /* what should happen when we tap on button,
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
              decrement();
            },
            color: myColor),
        Text('$counter', style: TextStyle(color: myColor)),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              increment();
            },
            color: myColor),
      ],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: myColor,
          onTap: (val) {
            setState(() => selectedIndex = val);
          },
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
                label: 'action 1', icon: Icon(Icons.android)),
            BottomNavigationBarItem(
                label: 'action 2', icon: Icon(Icons.touch_app)),
            BottomNavigationBarItem(label: 'action 3', icon: Icon(Icons.work)),
            BottomNavigationBarItem(
                label: 'action 4', icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(
                label: 'action 5', icon: Icon(Icons.account_circle)),
          ]),
    );
  }

  Widget buildListView() {
    return ListView(
      children: <Widget>[
        for (var i = 0; i < titles.length; i++) ...[
          InkWell(
            onTap: () => Navigator.pushNamed(context, titles[i].values.first),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: colors[Random().nextInt(colors.length)],
              ),
              margin: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  titles[i].keys.first,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 30)
      ],
    );
  }

  Widget buildGridView() {
    return GridView.builder(
        itemCount: titles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width > 600 ? 4 : 2, childAspectRatio: 1.3),
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, titles[i].values.first),
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: colors[Random().nextInt(colors.length)],
              ),
              child: Center(
                child: Text(
                  titles[i].keys.first,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }
}
