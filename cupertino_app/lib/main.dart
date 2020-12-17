import 'package:cupertino_app/model/app_state_model.dart';
import 'package:cupertino_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel()..loadAnimals(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateModel>(context);
    return CupertinoApp(
      theme: state.getTheme(),
      title: 'Animals',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
