import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_parking/RegisterLogin.dart';

import 'Destinations.dart';
import 'Profile.dart';
import 'Recommendations.dart';

class Dashboard extends StatefulWidget {
  final String arg1;

  const Dashboard({
    Key? key,
    required this.arg1,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int inddex = 0;
  late DatabaseReference dbref;

  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String uid = widget.arg1;
    List<Widget> tabs = [
      Destinations(arg1: uid),
      Recommendations(arg1: uid),
      Profile(arg1: uid)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: GoogleFonts.roboto()),
        centerTitle: false,
        leading: Icon(Icons.home),
        actions: [
          IconButton(icon: Icon(Icons.logout_rounded), onPressed: () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Logged out");
          }),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: tabs[inddex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: inddex,
        onTap: (index) {
          setState(() {
            inddex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city_rounded),
            label: "Destinations",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_rounded),
            label: "Recomendations",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: "Profile",
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
