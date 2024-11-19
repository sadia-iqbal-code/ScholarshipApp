import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class needScholarships extends StatefulWidget {
  // final VoidCallback onClose;
  const needScholarships({
    super.key,
  });

  @override
  State<needScholarships> createState() => _needScholarshipsState();
}

class _needScholarshipsState extends State<needScholarships> {
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
        'category': 'Need-based', // Ensures the correct category
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
              icon: Icon(Icons.arrow_back_rounded)),
          title: Row(
            children: [
              Text(
                'Need-Based Scholarships',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
        body: Stack(children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('scholarships')
                  .where('category', isEqualTo: 'need-based')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
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
                            color: Colors.black87),
                      ),
                      subtitle: Text(
                        scholarship['description'] ?? '',
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      trailing: TextButton(
                          onPressed: () async {
                            final url = scholarship['url'];
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Apply Now',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                    );
                  },
                );
                // Display scholarships here
              }),

        ]));
  }
}
