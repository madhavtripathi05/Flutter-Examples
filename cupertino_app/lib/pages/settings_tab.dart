import 'package:cupertino_app/model/app_state_model.dart';
import 'package:cupertino_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      bool isDarkTheme = model.getTheme() == darkTheme;

      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
          SliverFillRemaining(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Dark Mode'),
                CupertinoSwitch(
                  value: isDarkTheme,
                  onChanged: (val) {
                    isDarkTheme = val;
                    model.setTheme(isDarkTheme ? darkTheme : lightTheme);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
