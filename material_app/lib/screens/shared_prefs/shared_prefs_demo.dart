import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _prefs = SharedPreferences.getInstance();

class SharedPrefsDemo extends StatefulWidget {
  static const routeName = '/shared-prefs';
  @override
  _SharedPrefsDemoState createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  var dataController = TextEditingController();
  bool isEmpty = false;
  String data;

  Future<void> getData() async {
    var prefs = await _prefs;
    setState(() {
      data = prefs.getString('data');
      isEmpty = data == null || data == '';
    });
  }

  Future<void> setData(String data) async {
    var prefs = await _prefs;
    prefs.setString('data', data);
    setState(() {
      this.data = data;
      isEmpty = data == null || data == '';
    });
  }

  Future<void> removeData(String key) async {
    var prefs = await _prefs;
    prefs.remove(key);
    await getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  InputDecoration decor(String label, String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      labelText: label,
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Prefs Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              !isEmpty ? 'Data: $data' : 'No data found! please add Something.',
              style: TextStyle(
                  color: isEmpty ? Colors.red : Colors.blue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dataController,
                decoration: decor('Enter Data', 'Enter Something'),
              ),
            ),
            RaisedButton(
                child: Text('Add/Update'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async => setData(dataController.text)),
            RaisedButton(
                child: Text('Remove Data'),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async => removeData('data'))
          ],
        ),
      ),
    );
  }
}
