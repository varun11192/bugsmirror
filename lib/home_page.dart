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
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Complaint Title',
                    ),
                    onSaved: (value) {
                      title = value as String;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide summary.';
                      }
                      return null;
                    },
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      labelText: 'Complaint Summary',
                    ),
                    onSaved: (value) {
                      summary = value as String;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please Rate Severity';
                      }
                      return null;
                    },
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Severity out of 10',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      severity = value as String;
                    },
                  ),
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
          )
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
        'email': title,
        'username': summary,
        'password': severity,
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
