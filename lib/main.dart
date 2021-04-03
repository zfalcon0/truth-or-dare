import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/tdicon.jpg'),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> with TickerProviderStateMixin {
  var lastposition = 0.0;
  var random = new Random();
  AnimationController animationController;

  get duration => null;
  double getRandomNumber(){
    lastposition =  random.nextDouble();
    return lastposition;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5)
    );
  }

  spinTheBottle(){
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5)
    );
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    var curves;
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/td.jpg",
                fit: BoxFit.fill),

          ),
          Center(
            child: Container(
                child: RotationTransition (
                  turns: Tween(begin: lastposition , end: getRandomNumber()).animate(
                      new CurvedAnimation(parent: animationController , curve: Curves.linear)   ),
                  child: GestureDetector(
                      onTap: (){

                          setState(() {
                            spinTheBottle();
                          });
    
    },
                    child: Image.asset("assets/bottle.jpg",
                    width: 250, height: 250,
                    ),
                  ),
    ),
            ),
          )
        ],
      ),
    );
  }
}
