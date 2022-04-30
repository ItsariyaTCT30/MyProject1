import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Index.dart';

//import 'Screens/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Index(),
    );
  }
}
