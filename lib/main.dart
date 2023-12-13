import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import './splash.dart';
import './home_page.dart';
import './login_page.dart';
import './sign_up_page.dart';
import 'admin_dashboard.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyC4eXTZfzJV6cG705KWYJ-UefsP3REUqhQ',
        appId: '1:1058262718662:web:7de92885754954fa899fc7',
        messagingSenderId: '1058262718662',
        projectId: 'bugsmirror-90d13',
        //90d13
        // Your web Firebase config optionsnp
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/admin_dashboard':(context) => AdminDashboard(),
      },
    );
  }
}