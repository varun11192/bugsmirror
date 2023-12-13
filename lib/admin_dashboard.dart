import 'package:bugs/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  final String id;
  final String title;
  final String summary;
  final String severity;
  final String status;

  Complaint({
    required this.id,
    required this.title,
    required this.summary,
    required this.severity,
    required this.status,
  });
}
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var complaints = snapshot.data!.docs;
                  List<Widget> complaintWidgets = [];
                  for (var complaint in complaints) {
                    var data = complaint.data() as Map<String, dynamic>;
                    var email = data['email'];
                    var title = data['title'];
                    var summary = data['summary'];
                    var severity = data['severity'];

                    var complaintWidget = ListTile(
                      title: Text('Email: $email'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title: $title'),
                          Text('Summary: $summary'),
                          Text('Severity: $severity'),
                        ],
                      ),
                    );

                    complaintWidgets.add(complaintWidget);
                  }

                  return ListView(
                    children: complaintWidgets,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast(message: "Successfully signed out");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Sign out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
