import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String title = '';
  String summary = '';
  String severity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("HomePage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome to Complaints",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ... (existing code)

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _trySubmit();
                    },
                    child: Text('Submit Complaint'),
                  ),
                ],
              ),
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

          // Add the ListView here
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
        ],
      ),
    );
  }

  void _trySubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Get an instance of Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a map containing the form data
      Map<String, dynamic> formData = {
        'email': email,
        'title': title,
        'summary': summary,
        'severity': severity,
      };

      try {
        // Add the form data to the "complaints" collection in Firestore
        await firestore.collection('complaints').add(formData);

        // Show a success message or perform any other action
        showToast(message: 'Form data saved to Firestore successfully!');
      } catch (error) {
        // Handle errors (show an error message or log the error)
        showToast(message: 'Error saving form data to Firestore');
        print('Error: $error');


      }
    }
  }
}
