import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Reserve extends StatefulWidget {
  final int arg1;
  final int arg2;
  final int arg3;
  final int arg4;
  final int arg5;
  final String arg6;

  const Reserve({
    Key? key,
    required this.arg1,
    required this.arg2,
    required this.arg3,
    required this.arg4,
    required this.arg5,
    required this.arg6,
  }) : super(key: key);

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  final dbref = FirebaseDatabase.instance.ref().child("1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination");
  late DatabaseReference dbref2 = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    int id = widget.arg1;
    int p1 = widget.arg2;
    int p2 = widget.arg3;
    int p3 = widget.arg4;
    int p4 = widget.arg5;
    int choice = 0;
    String uid = widget.arg6;
    dbref2.child("Users").child("$uid").update({"ParkingSpot":choice});


    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve'),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 20.0,
        onPressed: () {
          if(choice==0){
            dbref2.child("Users").child("$uid").update({"ParkingSpot":choice});
            Navigator.pop(context);
          }
          else{
            Fluttertoast.showToast(
                msg: "Please un-reserve before leaving");
          }


    },
      ),),
      body: StreamBuilder<Object>(
        stream: dbref.child('$id').onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var data = (snapshot.data! as DatabaseEvent).snapshot;
          return Center(
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.local_parking),
                        color: data.child('p1').value == 0 ? Colors.green : Colors.red,
                        onPressed: () {
                          if (data.child('p1').value == 0 && choice == 0) {
                            dbref.child('$id').update({'p1': 1});
                            choice = 1;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          } else if(choice == 1) {
                            dbref.child('$id').update({'p1': 0});
                            choice = 0;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          }
                        },
                      ),
                      Text("B1"),
                      SizedBox(width: 100),
                      IconButton(
                        icon: Icon(Icons.local_parking),
                        color: data.child('p2').value == 0 ? Colors.green : Colors.red,
                        onPressed: () {
                          if (data.child('p2').value == 0 && choice == 0) {
                            dbref.child('$id').update({'p2': 1});
                            choice = 2;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          } else if(choice == 2){
                            dbref.child('$id').update({'p2': 0});
                            choice = 0;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          }
                        },
                      ),
                      Text("B2"),
                    ],
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.local_parking),
                        color: data.child('p3').value == 0 ? Colors.green : Colors.red,
                        onPressed: () {
                          if (data.child('p3').value == 0 && choice == 0) {
                            dbref.child('$id').update({'p3': 1});
                            choice = 3;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          } else if(choice == 3) {
                            dbref.child('$id').update({'p3': 0});
                            choice = 0;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          }
                        },
                      ),
                      Text("A1"),
                      SizedBox(width: 100),
                      IconButton(
                        icon: Icon(Icons.local_parking),
                        color: data.child('p4').value == 0 ? Colors.green : Colors.red,
                        onPressed: () {
                          if (data.child('p4').value == 0 && choice == 0) {
                            dbref.child('$id').update({'p4': 1});
                            choice = 4;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          } else if(choice == 4) {
                            dbref.child('$id').update({'p4': 0});
                            choice = 0;
                            dbref2.child("Users").child(uid).update({"ParkingSpot":choice});
                          }
                        },
                      ),
                      Text("A2"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
