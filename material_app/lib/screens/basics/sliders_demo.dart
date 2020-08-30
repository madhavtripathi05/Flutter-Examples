import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidersDemo extends StatefulWidget {
  static const routeName = '/sliders-demo';
  @override
  _SlidersDemoState createState() => _SlidersDemoState();
}

class _SlidersDemoState extends State<SlidersDemo> {
  double myValue1 = 0;
  double myValue2 = 0;
  double minValue = 0;
  double maxValue = 10;
  Text customText(String data, Color color) => Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sliders Demo'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          customText('Material Slider', Colors.redAccent),
          Slider(
            activeColor: Colors.redAccent,
            label: '$myValue1',
            divisions: 10,
            min: 0,
            max: 100,
            value: myValue1,
            onChanged: (val) => setState(() => myValue1 = val),
          ),
          customText('Cupertino Slider', Colors.greenAccent),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSlider(
                activeColor: Colors.greenAccent,
                divisions: 10,
                min: 0,
                max: 10,
                value: myValue2,
                onChanged: (val) => setState(() => myValue2 = val),
              ),
              customText('$myValue2',Colors.greenAccent),
            ],
          ),
          customText('Range Slider', Colors.blueAccent),
          RangeSlider(
            activeColor: Colors.blueAccent,
              divisions: 10,
              labels: RangeLabels('$minValue', '$maxValue'),
              min: 0,
              max: 10,
              values: RangeValues(minValue, maxValue),
              onChanged: (RangeValues values) {
                setState(() {
                  minValue = values.start;
                  maxValue = values.end;
                });
              }),
        ],
      ),
    );
  }
}
