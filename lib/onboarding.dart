import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:scholarshipapp/newLogin.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = [
      PageModel(
        color: Color(0xFF5886d6),
        imageAssetPath: 'assets/2.png',
        title: 'Welcome to Scholarship App',
        body: 'Discover various scholarship opportunities.',
        doAnimateImage: true,
      ),
      PageModel(
        color: Color(0xFF64d622),
        imageAssetPath: 'assets/3.png',
        title: 'Easy Application Process',
        body: 'Apply for scholarships with just a few clicks.',
        doAnimateImage: true,
      ),
      PageModel(
        color: Color(0xFFf39a21),
        bodyColor: Colors.white,
        imageAssetPath: 'assets/fati.png',
        title: 'Stay Updated',
        body: 'Get notifications about new scholarships.',
        doAnimateImage: true,
      ),
    ];

    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        finishCallback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      ),
    );
  }
}
