import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//* double count tap to reset
//* long press button for +- 10
//* tap button for +- 1

class HandlingTaps extends StatefulWidget {
  static const routeName = '/handling-taps';
  @override
  _HandlingTapsState createState() => _HandlingTapsState();
}

style(Color color) => TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 30,
    color: color,
    fontWeight: FontWeight.bold);

class _HandlingTapsState extends State<HandlingTaps> {
  int count = 0;
  // assigning default value as 1
  void increment([int val = 1]) {
    if (count >= 0) setState(() => count += val);
  }

  void decrement([int val = 1]) {
    // error handling for handling negative nos.
    if (count > 0 && count - val >= 0) setState(() => count -= val);
  }

  void reset() {
    setState(() => count = 0);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Taps & Gestures'),
          centerTitle: true,
        ),
        body: Center(
          child: Row(
            children: [
              // wrap InkWell with any widget where you want to detect gesture/tap
              InkWell(
                onTap: increment,
                onLongPress: () {
                  increment(10);
                },
                // Color of splash effect
                splashColor: Colors.greenAccent,
                highlightColor: Colors.greenAccent,
                // your main widget
                child: Container(
                  width: 0.25 * width,
                  child: Text('+',
                      style: style(Colors.green), textAlign: TextAlign.center),
                ),
              ),
              Container(
                width: 0.5 * width,
                child: GestureDetector(
                  onDoubleTap: reset,
                  child: Text('$count',
                      style: style(Colors.blue), textAlign: TextAlign.center),
                ),
              ),
              Container(
                width: 0.25 * width,
                child: InkWell(
                  onTap: decrement,
                  // stop vibration on long press
                  enableFeedback: false,
                  splashColor: Colors.redAccent,
                  highlightColor: Colors.redAccent,
                  onLongPress: () {
                    decrement(10);
                  },
                  child: Text('-',
                      style: style(Colors.red), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ));
  }
}
