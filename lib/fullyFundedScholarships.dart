

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FullyFundedScholarships extends StatefulWidget {
  const FullyFundedScholarships({super.key});

  @override
  State<FullyFundedScholarships> createState() =>
      _FullyFundedScholarshipsState();
}

class _FullyFundedScholarshipsState extends State<FullyFundedScholarships> {
  String? selectedCategory;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  bool isAddingScholarship = false; // Tracks if the add form is open

  void _toggleAddScholarshipPanel() {
    setState(() {
      isAddingScholarship = !isAddingScholarship;
    });
  }

  void _addScholarship() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final url = urlController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty && url.isNotEmpty) {
      await FirebaseFirestore.instance.collection('scholarships').add({
        'title': title,
        'description': description,
        'url': url,
        'category': 'Fully-funded', // Ensures the correct category
      });

      // Clear the input fields
      titleController.clear();
      descriptionController.clear();
      urlController.clear();

      // Close the side panel
      _toggleAddScholarshipPanel();
    } else {
      // Show a message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fully Funded Scholarships',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
      body: Stack(
        children: [
          // Main scholarship list
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('scholarships')
                .where('category', isEqualTo: 'fully-funded')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No scholarships available.'));
              }

              final scholarships = snapshot.data!.docs;

              return ListView.builder(
                itemCount: scholarships.length,
                itemBuilder: (context, index) {
                  final scholarship =
                      scholarships[index].data() as Map<String, dynamic>;

                  return ListTile(
                    title: Text(
                      scholarship['title'] ?? '',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      scholarship['description'] ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    trailing: TextButton(
                      onPressed: () async {
                        final url = scholarship['url'] ?? '';
                        if (url.isNotEmpty && await canLaunch(url)) {
                          await launch(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not launch URL!')),
                          );
                        }
                      },
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

                ],
              ),
    );
  }
}
