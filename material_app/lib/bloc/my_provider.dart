import 'package:flutter/material.dart';
import 'my_bloc.dart';

class MyProvider extends InheritedWidget {
  final bloc = MyBloc();
  @override
  bool updateShouldNotify(_) {
    return true;
  }

  MyProvider({Key key, Widget child}) : super(key: key, child: child);

  static MyBloc of(BuildContext context) {
    // return (context.inheritFromWidgetOfExactType(MyProvider) as MyProvider)
    //     .bloc; deprecated
    return (context.dependOnInheritedWidgetOfExactType<MyProvider>()).bloc;
  }
}
