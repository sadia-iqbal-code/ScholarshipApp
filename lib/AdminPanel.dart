
import 'package:flutter/material.dart';
import 'package:scholarshipapp/MeritBasedScholarships.dart';
import 'package:scholarshipapp/ScholarshipAdminScreen.dart';
import 'package:scholarshipapp/fullyFundedScholarships.dart';
import 'package:scholarshipapp/needBasedScholarships.dart';



class Adminpanel extends StatefulWidget {
  @override
  AdminpanelState createState() => AdminpanelState();
}

class AdminpanelState extends State<Adminpanel> {
  int _selectedIndex = 0; // Track the selected menu item

  // List of screens to display
  final List<Widget> screens = [
    Center(child: Text('Welcome to Scholarship App',style: TextStyle(fontSize: 24),),),
    Center(child: ScholarshipAdminScreen()),
    Center(child: FullyFundedScholarships()),
    Center(child: meritScholarships() ),
    Center(child: needScholarships() ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Row(
        children: [
          // Sidebar
          Container(
            width: 400,
            color: Colors.blue[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(

                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text(
                      'Scholarships',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.school_sharp),
                  title: Text('Add Scholarships'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.school_sharp),
                  title: Text('Check Fully Funded Scholarships'),
                  onTap: () {

                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.school_sharp),
                  title: Text('Check Merit Based Scholarships'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.school_sharp),
                  title: Text('Check Need Based Scholarships'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ),
          // Content area
          Expanded(
            child: screens[_selectedIndex], // Display selected screen
          ),
        ],
      ),
    );
  }

}


