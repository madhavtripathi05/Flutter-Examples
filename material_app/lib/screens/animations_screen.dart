import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  static const routeName = '/animations-screen';
  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with TickerProviderStateMixin {
  Animation<double> objAnimation;
  Animation<double> sideObjAnimation;
  Animation<double> opacityAnimation;

  AnimationController objController;
  AnimationController opacityController;
  AnimationController sideObjController;
  @override
  void initState() {
    super.initState();
    //* Defines duration of animation and when to start, stop or restart.
    objController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    opacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    sideObjController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    //* Tween(short for between) describes a Range of value that our obj will animate on.
    objAnimation = Tween(begin: -50.0, end: -100.0).animate(
        CurvedAnimation(parent: objController, curve: Curves.easeInOutCirc));

    sideObjAnimation = Tween(begin: 0.0, end: -150.0).animate(
        CurvedAnimation(parent: sideObjController, curve: Curves.decelerate));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: opacityController, curve: Curves.ease));

    sideObjAnimation.addStatusListener((status) {});
  }

  onTap() {
    objController.forward();
    opacityController.forward();
    sideObjController.forward();
    if (objController.status == AnimationStatus.completed) {
      objController.reverse();
      sideObjController.reverse();
      opacityController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
        centerTitle: true,
      ),
      body: GestureDetector(
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
    );
  }

  Widget buildBox() {
    return FadeTransition(
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
    return AnimatedBuilder(
      animation: objAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: objAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Image.asset('assets/images/fc.png'),
    );
  }
}
