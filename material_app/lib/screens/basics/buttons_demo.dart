import 'package:flutter/material.dart';

class ButtonsDemo extends StatefulWidget {
  static const routeName = '/buttons';
  @override
  _ButtonsDemoState createState() => _ButtonsDemoState();
}

class _ButtonsDemoState extends State<ButtonsDemo> {
  List<String> dropdownItems = ['item 1', 'item 2', 'item 3'];
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buttons Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Types of Buttons:'),
          OutlineButton(
              textColor: Colors.red,
              highlightedBorderColor: Colors.red,
              onPressed: () => print('Outline Button pressed'),
              child: Text('Outline Button')),
          RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () => print('Raised Button'),
              child: Text('Raised Button')),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () => print('Flat Button'),
              child: Text('Flat Button')),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () => print('OK'),
                  icon: Icon(Icons.check),
                  label: Text('OK')),
              RaisedButton.icon(
                color: Colors.redAccent,
                onPressed: () => print('Cancel'),
                label: Text('Cancel'),
                icon: Icon(Icons.clear),
              ),
            ],
          ),
          DropdownButton(
            hint: Text('Select an item'),
            // current value of dropdown item.
            value: selectedItem,
// aligning widgets in Center
            /* Okay, bear with me here, So items except
              List<DropdownItem<String>> type. we can make
              a dynamic ^ list by mapping out dropdownItems
              to a Text widget and then finally convert it
              to a List and assign to items. */
            items: dropdownItems
                .map((item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ))
                .toList(),

            // change value when new item is selected.
            onChanged: (item) => setState(() => selectedItem = item),
          ),
        ],
      ),
    );
  }
}
