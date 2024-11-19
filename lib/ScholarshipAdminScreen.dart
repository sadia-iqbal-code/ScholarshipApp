import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipAdminScreen extends StatefulWidget {
  @override
  _ScholarshipAdminScreenState createState() => _ScholarshipAdminScreenState();
}

class _ScholarshipAdminScreenState extends State<ScholarshipAdminScreen> {
  String? selectedCategory;
  // List<String> categories = ['fully funded', 'merit-based', 'need-based'];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  final categoryController = TextEditingController();
  void _addScholarship() async {
    final newScholarship = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'url': _urlController.text,
      'category': selectedCategory,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection('scholarships')
        .add(newScholarship);

    FirebaseFirestore.instance
        .collection('scholarships')
        .where('category', isEqualTo: 'fully-funded') // Change based on screen
        .snapshots();

    // Clear input fields
    _titleController.clear();
    _descriptionController.clear();
    _urlController.clear();
  }

  void clearCategory() {
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Fully Funded Scholarships/NeedBased/MeritBased'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Title'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),maxLines: 3,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'URL'),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                items: ["fully funded", "merit-based", "need-based"].map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                value: selectedCategory,
              ),

                    SizedBox(height: 30),
                    TextButton(
                      onPressed: clearCategory,
                      child: Text(
                        'Clear Category',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _addScholarship,
                child: Text(
                  'Add Scholarship',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
        ]
      )
          ),
      )
        );
  }
}
