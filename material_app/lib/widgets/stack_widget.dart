import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class StackWidget extends StatefulWidget {
  static const routeName = 'stack-widget';
  @override
  _StackWidgetState createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  final tween = MultiTrackTween([
    Track("color1").add(
        Duration(seconds: 3), ColorTween(begin: Colors.red, end: Colors.blue),
        curve: Curves.decelerate),
    Track("color2").add(
        Duration(seconds: 2), ColorTween(begin: Colors.blue, end: Colors.green),
        curve: Curves.decelerate),
    Track("color3").add(
        Duration(seconds: 1), ColorTween(begin: Colors.green, end: Colors.red),
        curve: Curves.decelerate),
    Track("rotation3").add(Duration(seconds: 3), ConstantTween(0.0)).add(
        Duration(seconds: 3), Tween(begin: 0.0, end: 3.14),
        curve: Curves.decelerate),
    Track("rotation2").add(Duration(seconds: 2), ConstantTween(0.0)).add(
        Duration(seconds: 2), Tween(begin: 0.0, end: 3.14),
        curve: Curves.decelerate),
    Track("rotation1").add(Duration(seconds: 1), ConstantTween(0.0)).add(
        Duration(seconds: 1), Tween(begin: 0.0, end: 3.14),
        curve: Curves.decelerate),
  ]);

  Widget buildAnimation(double size, int num) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      duration: tween.duration,
      tween: tween,
      builder: (context, animation) {
        return Transform.rotate(
          angle: animation["rotation$num"],
          child: Container(
            decoration: BoxDecoration(
                color: animation["color$num"],
                borderRadius: BorderRadius.circular(20)),
            width: size,
            height: size,
            padding: EdgeInsets.all(7),
            child: Text(
              'element $num',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget coloredContainer(Color color, double size, int elem) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Text('element $elem', style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(
          color: color , borderRadius: BorderRadius.circular(20)),
      height: size,
      width: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            // buildAnimation(300, 3), //last element
            // buildAnimation(200, 2), //middle element
            // buildAnimation(100, 1), //first element
            //to see animation comment the following 3 lines and uncomment the above 3 lines
            coloredContainer(Colors.red, 300, 3), //last element
            coloredContainer(Colors.green, 200, 2),//middle element
            coloredContainer(Colors.blue, 100, 1),//first element
          ],
        ),
      ),
    );
  }
}
