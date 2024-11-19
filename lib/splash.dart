import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scholarshipapp/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// SingleTickerProviderStateMixin is used to provide a single Ticker to an animation
// controller in a StatefulWidget. It helps manage the lifecycle of the animation by ensuring the animation can be synchronized with the screen's refresh rate.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation back and forth

    // Define the animation from scale 0.9 to 1.1
    _animation = Tween<double>(begin: 0.6, end: 2.5).animate(_controller);

    // Navigate to the next screen after the animation
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 250.0),
      child: Column(children: [
        Center(
          // scale transistion is used for zoom in and zoom out effect
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'assets/fff.png',
              width: 180,
              height: 180,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Welcome to My Scholarship App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
