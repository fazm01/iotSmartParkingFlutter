import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/Destinations.dart';
import 'Dashboard.dart';
import 'RegisterLogin.dart';
import 'firebase_options.dart';

// ...


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBSkGur6GpkxzG8iYoB7uv7uBm1kHWf-dc',
        appId: '1:980868147028:android:18b356a26fc876c5834ac1',
        messagingSenderId: '980868147028',
        projectId: 'smartparking-bd17d',
        databaseURL: 'https://smartparking-bd17d-default-rtdb.firebaseio.com',
        storageBucket: 'smartparking-bd17d.appspot.com',
  ),
  );
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'main',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
}

