import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final String arg1;

  const Profile({
    Key? key,
    required this.arg1,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DatabaseReference dbref = FirebaseDatabase.instance.ref();
  final search = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    String uid = widget.arg1;
    String name = dbref.child("Users/$uid/name").toString();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.person, size: 30,),
              radius: 50,
            ),
            SizedBox(height: 16),
            Text(
              "$name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            SizedBox(height: 16),

            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
