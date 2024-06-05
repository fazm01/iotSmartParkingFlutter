import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Reserve.dart';

class Destinations extends StatefulWidget {
  final String arg1;

  const Destinations({
    Key? key,
    required this.arg1,
  }) : super(key: key);


  @override
  State<Destinations> createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations> {
  late DatabaseReference dbref = FirebaseDatabase.instance
      .ref()
      .child("1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination");
  late DatabaseReference dbref2 = FirebaseDatabase.instance
      .ref();
  final search = TextEditingController();
  String filter = "0";
  int choice = 0;


  int location_Id = 0;

  @override
  Widget build(BuildContext context) {
    String uid = widget.arg1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextFormField(
                controller: search,
                decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search)),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            search.text = "";
                          });
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.blue,
                        )),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "Mall";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            search.text == "Mall" ? Colors.blue : Colors.white,
                        foregroundColor:
                            search.text == "Mall" ? Colors.white : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Malls'),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "Park";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            search.text == "Park" ? Colors.blue : Colors.white,
                        foregroundColor:
                            search.text == "Park" ? Colors.white : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Parks'),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "Hotel";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            search.text == "Hotel" ? Colors.blue : Colors.white,
                        foregroundColor:
                            search.text == "Hotel" ? Colors.white : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Hotels'),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "Restraunt";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: search.text == "Restraunt"
                            ? Colors.blue
                            : Colors.white,
                        foregroundColor: search.text == "Restraunt"
                            ? Colors.white
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Restaurants'),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "New Cairo";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: search.text == "New Cairo"
                            ? Colors.blue
                            : Colors.white,
                        foregroundColor: search.text == "New Cairo"
                            ? Colors.white
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('New Cairo'),
                    ),
                    SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          search.text = "Heliopolis";
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: search.text == "Heliopolis"
                            ? Colors.blue
                            : Colors.white,
                        foregroundColor: search.text == "Heliopolis"
                            ? Colors.white
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Heliopolis'),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
              Container(
                height: 500,
                child: FirebaseAnimatedList(
                  query: dbref.orderByChild('D_Name'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final title = snapshot.child('D_Name').value.toString();
                    final title2 = snapshot.child('D_Type').value.toString();
                    final title3 = snapshot.child('D_Address').value.toString();
                    final title4 = snapshot.child('D_Type').value.toString();

                    if (search.text.isEmpty) {
                      return ListTile(
                          leading: snapshot.child('D_Type').value.toString() ==
                                  'Mall'
                              ? Icon(Icons.shopping_bag_rounded,
                                  color: Colors.red)
                              : snapshot.child('D_Type').value.toString() ==
                                      'Restraunt'
                                  ? Icon(Icons.restaurant_rounded,
                                      color: Colors.yellow.shade700)
                                  : snapshot.child('D_Type').value.toString() ==
                                          'Park'
                                      ? Icon(Icons.park_rounded,
                                          color: Colors.green)
                                      : Icon(Icons.hotel_rounded,
                                          color: Colors.blueAccent),
                          title:
                              Text(snapshot.child('D_Name').value.toString()),
                          subtitle: Text(
                              snapshot.child('D_Type').value.toString() +
                                  " in " +
                                  snapshot.child('D_Address').value.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Uri url = Uri.parse(snapshot
                                      .child('D_Link')
                                      .value
                                      .toString());
                                  launchUrl(url);
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  child: Center(child: Text('View')),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: (){
                                  location_Id = int.parse(snapshot.child('D_ID').value.toString());
                                  dbref2.update({'location_Id': location_Id});
                                  int ID = int.parse(snapshot.child('D_ID').value.toString());
                                  int p1 = int.parse(snapshot.child('p1').value.toString());
                                  int p2 = int.parse(snapshot.child('p2').value.toString());
                                  int p3 = int.parse(snapshot.child('p3').value.toString());
                                  int p4 = int.parse(snapshot.child('p4').value.toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reserve( arg1 :ID, arg2:p1, arg3:p2, arg4:p3, arg5:p4, arg6: uid)),
                                  );

                                },

                                child: Container(
                                  height: 30,
                                  width: 50,
                                  child: Center(child: Text('Reserve')),
                                ),
                              ),
                            ],
                          ));
                    } else if (title
                            .toLowerCase()
                            .contains(search.text.toLowerCase()) ||
                        title2
                            .toLowerCase()
                            .contains(search.text.toLowerCase()) ||
                        title3
                            .toLowerCase()
                            .contains(search.text.toLowerCase())) {
                      return ListTile(
                          leading: snapshot.child('D_Type').value.toString() ==
                              'Mall'
                              ? Icon(Icons.shopping_bag_rounded,
                              color: Colors.red)
                              : snapshot.child('D_Type').value.toString() ==
                              'Restraunt'
                              ? Icon(Icons.restaurant_rounded,
                              color: Colors.yellow.shade700)
                              : snapshot.child('D_Type').value.toString() ==
                              'Park'
                              ? Icon(Icons.park_rounded,
                              color: Colors.green)
                              : Icon(Icons.hotel_rounded,
                              color: Colors.blueAccent),
                          title:
                          Text(snapshot.child('D_Name').value.toString()),
                          subtitle: Text(
                              snapshot.child('D_Type').value.toString() +
                                  " in " +
                                  snapshot.child('D_Address').value.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Uri url = Uri.parse(snapshot
                                      .child('D_Link')
                                      .value
                                      .toString());
                                  launchUrl(url);
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  child: Center(child: Text('View')),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: (){
                                  location_Id = int.parse(snapshot.child('D_ID').value.toString());
                                  dbref2.update({'location_Id': location_Id});
                                  int ID = int.parse(snapshot.child('D_ID').value.toString());
                                  int p1 = int.parse(snapshot.child('p1').value.toString());
                                  int p2 = int.parse(snapshot.child('p2').value.toString());
                                  int p3 = int.parse(snapshot.child('p3').value.toString());
                                  int p4 = int.parse(snapshot.child('p4').value.toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reserve( arg1 :ID, arg2:p1, arg3:p2, arg4:p3, arg5:p4, arg6: uid)),
                                  );

                                },

                                child: Container(
                                  height: 30,
                                  width: 50,
                                  child: Center(child: Text('Reserve')),
                                ),
                              ),
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
