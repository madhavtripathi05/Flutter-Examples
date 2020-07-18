import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_app/screens/screen1.dart';

class AnimationsScreen extends StatefulWidget {
  static const routeName = '/animations-screen';
  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with TickerProviderStateMixin {
/*
* TickerProviderStateMixin creates a ticker that ticks with 
* each frame which is needed by AnimationController, It also
* disposes when our stateful widget is disposed, that's why
* we provide "this" as "vsync" property in AnimationController
*/
  AnimationController objController;
  Animation<double> objAnimation;

  Animation<double> sideObjAnimation;
  Animation<double> opacityAnimation;

  AnimationController opacityController;
  AnimationController sideObjController;

  @override
  void initState() {
    super.initState();
    //* Defines duration of animation and when to start, stop or restart.
    objController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    //* Tween(short for 'between') describes a Range
    //* of values that our obj will animate on.
    objAnimation = Tween(begin: -50.0, end: -100.0).animate(CurvedAnimation(
      parent: objController,
      curve: Curves.easeInOutCirc,
    ));

    opacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    sideObjController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    sideObjAnimation = Tween(begin: 0.0, end: -150.0).animate(
        CurvedAnimation(parent: sideObjController, curve: Curves.decelerate));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: opacityController, curve: Curves.ease));

    sideObjAnimation.addStatusListener((status) {});
  }

  onTap() {
    //* starting the animation
    objController.forward();
    opacityController.forward();
    sideObjController.forward();
    //* if it's completed, you can also play it in reverse
    if (objController.status == AnimationStatus.completed) {
      objController.reverse();
      sideObjController.reverse();
      opacityController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Animations'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Center(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  buildAnimation(),
                  buildSideObj(),
                  buildSideObj(true),
                  buildBox(),
                ],
              ),
            ),
            onTap: onTap,
          ),
          //* if you're planning to make simple animations for page
          //* Transitions, check this package called "animations".
          //* it's very simple to use:
          OpenContainer(
            transitionDuration: Duration(seconds: 1),
            //* Widget before animation:
            closedBuilder: (context, action) => FlatButton(
                onPressed: () => action(), child: Text('Open Container')),
            //! Use this only for Page transitions
            //* Screen which will opened after animation.
            openBuilder: (context, action) => Screen1(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //* this package also has Fade Animation for Alerts
          showModal(
              configuration: FadeScaleTransitionConfiguration(
                  transitionDuration: Duration(seconds: 1)),
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  content: Text('Fade Scale Transition'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'),
                    ),
                  ],
                );
              });
        },
        child: Icon(FlutterIcons.open_in_app_mco),
      ),
    );
  }

  Widget buildBox() {
    //* Similarly, you can also create an opacity animation by
    //* passing 0.0-1.0 as values in Tween and using FadeTransition
    return FadeTransition(
      //* opacity changes according to our Animation
      opacity: opacityAnimation,
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset('assets/images/ig_transparent.png'),
      ),
    );
  }

// checking if it's the right object or left
  Widget buildSideObj([bool right = false]) {
    return AnimatedBuilder(
        animation: sideObjAnimation,
        builder: (context, child) {
          return Positioned(
            left: right ? sideObjAnimation.value : 10,
            top: 50,
            right: right ? 10 : sideObjAnimation.value,
            child: Container(
                height: 100,
                width: 100,
                child: right
                    ? Image.asset('assets/images/like.png')
                    : Image.asset('assets/images/share.png')),
          );
        });
  }

  Widget buildAnimation() {
    //* AnimatedBuilder takes animation and builds it
    return AnimatedBuilder(
      animation: objAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          //* image will move from -50.0 to -100.0
          //* as specified in Tween
          top: objAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Image.asset('assets/images/fc.png'),
    );
  }
}
