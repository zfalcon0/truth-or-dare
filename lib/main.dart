import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:onb/MyApp.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() {
  runApp(App(new MyApp()));
}

class App extends StatelessWidget {
  App(MyApp myApp);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/tdgif.gif',
          height: 10000,
          width: 10000,),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.amber,
        duration: 3000,

      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        body: OnBoard(
          pageController: _pageController,
          onSkip: () {
            runApp(MyApp());
            // print('skipped');
          },
          onDone: () {

            runApp(MyApp());
            // print('done tapped');
          },
          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
            color: Colors.brown.shade300,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Colors.deepOrangeAccent,
            activeColor: Colors.deepOrange,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          skipButton: TextButton(
            onPressed: () {
              runApp(MyApp());
              // print('skipped');
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget child) {
              return InkWell(
                onTap: () => _onNextTap(state),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.redAccent, Colors.deepOrangeAccent],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "Done" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      runApp(MyApp());
      // print("done");
    }
  }
}



final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Play Truth Or Dare",
    description: "Get to know your friends by playing a fun game of Truth Or Dare! ",
    imgUrl: "assets/tdgif2.gif",
  ),
  const OnBoardModel(
    title: "Track your progress with statistics",
    description:
    "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/tdgif.gif',
  ),
  const OnBoardModel(
    title: "Create photo comparissions and share your results",
    description:
    "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/tdicon.jpg',
  ),
];
