import 'package:admin_web_portal/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/login_screen.dart';

Future<void> main() async {

  FirebaseOptions options = const FirebaseOptions(
      apiKey: 'AIzaSyCLw1NN8EyWSqWiDjjXzjaoFPM5M9L48Vk',
      authDomain: "skill-exchange-app-76274.firebaseapp.com",
      projectId: 'skill-exchange-app-76274',
      storageBucket: "skill-exchange-app-76274.appspot.com",
      messagingSenderId: "501829412093",
      appId: "1:501829412093:web:f0b3324167a448e9834a94",
      measurementId: "G-JQTPDSC8BQ"  );
  await Firebase.initializeApp(options: options);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin web portal',
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? HomeScreen() :const LoginScreen(),
    );
  }
}


