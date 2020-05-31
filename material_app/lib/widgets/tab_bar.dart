import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  static const routeName = '/tabBar-demo';

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar Demo'),
          centerTitle: true,
          bottom: TabBar(
            controller: _controller,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Stuff',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
              Tab(
                icon: Icon(Icons.account_circle),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _controller, children: [
          Center(child: Text('Home Page')),
          Center(child: Text('Stuff List')),
          Center(child: Text('Favorite Items')),
          Center(child: Text('Your Name')),
        ]),
      ),
    );
  }
}
