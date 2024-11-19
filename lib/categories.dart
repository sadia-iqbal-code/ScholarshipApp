

import 'package:flutter/material.dart';

import 'package:scholarshipapp/MeritBasedScholarships.dart';


import 'package:scholarshipapp/fullyFundedScholarships.dart';

import 'package:scholarshipapp/needBasedScholarships.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  // bool showRightScreen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.yellow,
                child: Image(
                  image: AssetImage('assets/fff.png'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullyFundedScholarships()));
                },
                child: Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Check Fully Funded Scholarships.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return meritScholarships();
                  }));
                },
                child: Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Check Merit-based Scholarships.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return needScholarships();
                  }));
                },
                child: Container(
                    height: 60,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Check Need-based Scholarships.',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
