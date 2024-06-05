import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Reserve.dart';

class Recommendations extends StatefulWidget {
  final String arg1;

  const Recommendations({
    Key? key,
    required this.arg1,
  }) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  late DatabaseReference dbref = FirebaseDatabase.instance
      .ref()
      .child("1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination");
  late DatabaseReference dbref2 = FirebaseDatabase.instance
      .ref();
  final search = TextEditingController();
  String filter = "0";
  int choice = 0;


  int location_Id = 0;

  get list1 => null;

  get list2 => null;

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
              Container(
                height: 500,
                child: FirebaseAnimatedList(
                  query: dbref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final title = snapshot
                        .child('D_Name')
                        .value
                        .toString();
                    final title2 = snapshot
                        .child('D_Type')
                        .value
                        .toString();
                    final title3 = snapshot
                        .child('D_Address')
                        .value
                        .toString();
                    final title4 = snapshot
                        .child('D_Type')
                        .value
                        .toString();

                    if (search.text.isEmpty) {
                      return ListTile(
                          leading: snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Mall'
                              ? Icon(Icons.shopping_bag_rounded,
                              color: Colors.red)
                              : snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Restraunt'
                              ? Icon(Icons.restaurant_rounded,
                              color: Colors.yellow.shade700)
                              : snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Park'
                              ? Icon(Icons.park_rounded,
                              color: Colors.green)
                              : Icon(Icons.hotel_rounded,
                              color: Colors.blueAccent),
                          title:
                          Text(snapshot
                              .child('D_Name')
                              .value
                              .toString()),
                          subtitle: Text(
                              snapshot
                                  .child('D_Type')
                                  .value
                                  .toString() +
                                  " in " +
                                  snapshot
                                      .child('D_Address')
                                      .value
                                      .toString()),
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
                                onPressed: () {
                                  location_Id = int.parse(snapshot
                                      .child('D_ID')
                                      .value
                                      .toString());
                                  dbref2.update({'location_Id': location_Id});
                                  int ID = int.parse(snapshot
                                      .child('D_ID')
                                      .value
                                      .toString());
                                  int p1 = int.parse(snapshot
                                      .child('p1')
                                      .value
                                      .toString());
                                  int p2 = int.parse(snapshot
                                      .child('p2')
                                      .value
                                      .toString());
                                  int p3 = int.parse(snapshot
                                      .child('p3')
                                      .value
                                      .toString());
                                  int p4 = int.parse(snapshot
                                      .child('p4')
                                      .value
                                      .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Reserve(arg1: ID,
                                                arg2: p1,
                                                arg3: p2,
                                                arg4: p3,
                                                arg5: p4,
                                                arg6: uid)),
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
                          leading: snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Mall'
                              ? Icon(Icons.shopping_bag_rounded,
                              color: Colors.red)
                              : snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Restraunt'
                              ? Icon(Icons.restaurant_rounded,
                              color: Colors.yellow.shade700)
                              : snapshot
                              .child('D_Type')
                              .value
                              .toString() ==
                              'Park'
                              ? Icon(Icons.park_rounded,
                              color: Colors.green)
                              : Icon(Icons.hotel_rounded,
                              color: Colors.blueAccent),
                          title:
                          Text(snapshot
                              .child('D_Name')
                              .value
                              .toString()),
                          subtitle: Text(
                              snapshot
                                  .child('D_Type')
                                  .value
                                  .toString() +
                                  " in " +
                                  snapshot
                                      .child('D_Address')
                                      .value
                                      .toString()),
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
                                onPressed: () {
                                  location_Id = int.parse(snapshot
                                      .child('D_ID')
                                      .value
                                      .toString());
                                  dbref2.update({'location_Id': location_Id});
                                  int ID = int.parse(snapshot
                                      .child('D_ID')
                                      .value
                                      .toString());
                                  int p1 = int.parse(snapshot
                                      .child('p1')
                                      .value
                                      .toString());
                                  int p2 = int.parse(snapshot
                                      .child('p2')
                                      .value
                                      .toString());
                                  int p3 = int.parse(snapshot
                                      .child('p3')
                                      .value
                                      .toString());
                                  int p4 = int.parse(snapshot
                                      .child('p4')
                                      .value
                                      .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Reserve(arg1: ID,
                                                arg2: p1,
                                                arg3: p2,
                                                arg4: p3,
                                                arg5: p4,
                                                arg6: uid)),
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

  double calculateCosineSimilarity(List<int>? userOneHotEncodedData1,
      List<int>? userOneHotEncodedData2) {
    double dotProduct = 0.0;
    double magnitude1 = 0.0;
    double magnitude2 = 0.0;
    for (int i = 0; i < list1.length; i++) {
      dotProduct += list1[i] * list2[i];
      magnitude1 += list1[i] * list1[i];
      magnitude2 += list2[i] * list2[i];
    }
    magnitude1 = sqrt(magnitude1);
    magnitude2 = sqrt(magnitude2);
    double cosineSimilarity = dotProduct / (magnitude1 * magnitude2);
    return cosineSimilarity;
  }

  void oneHotEnc() {
    Map<String, Map<String, bool>> reservationData = {};
    Map<String, List<int>> oneHotEncodedData = {};
    for (String userId in reservationData.keys) {
      Map<String, bool>? userReservationData = reservationData[userId];
      List<int> userOneHotEncodedData = [];
      for (String location in [
        'New Cairo',
        'Heliopolis',
        'Hotels',
        'Malls',
        'Parks',
        'Restaurants'
      ]) {
        userOneHotEncodedData.add(
            userReservationData!.containsKey(location) ? 1 : 0);
      }
      oneHotEncodedData[userId] = userOneHotEncodedData;
    } //matrix Map<String, Map<String, double>> similarityMatrix = {}; for (String userId1 in reservationData.keys) { Map<String, double> userSimilarityScores = {}; for (String userId2 in reservationData.keys) { if (userId1 != userId2) { List<int>? userOneHotEncodedData1 = oneHotEncodedData[userId1]; List<int>? userOneHotEncodedData2 = oneHotEncodedData[userId2]; double cosineSimilarity = calculateCosineSimilarity(userOneHotEncodedData1, userOneHotEncodedData2); userSimilarityScores[userId2] = cosineSimilarity; } } similarityMatrix[userId1] = userSimilarityScores; } String currentUserId = '123'; Map<String, bool>? currentUserReservationData = reservationData[currentUserId]; List<int> currentUserOneHotEncodedData = []; for (String location in ['New Cairo', 'Heliopolis', 'Hotels', 'Malls', 'Parks', 'Restaurants']) { currentUserOneHotEncodedData.add(currentUserReservationData!.containsKey(location) ? 1 : 0); } Map<String, double>? similarityScores = similarityMatrix[currentUserId]; List<String> similarUserIds = similarityScores!.keys.toList()..sort((a, b) => similarityScores[b]!.compareTo(similarityScores[a]!)); List<String> recommendedLocations = []; for (String similarUserId in similarUserIds) { if (recommendedLocations.length >= 3) { break; } Map<String, bool>? similarUserReservationData = reservationData[similarUserId]; for (String location in ['New Cairo', 'Heliopolis', 'Hotels', 'Malls', 'Parks', 'Restaurants']) { if (similarUserReservationData!.containsKey(location) && !currentUserReservationData!.containsKey(location) && !recommendedLocations.contains(location)) { recommendedLocations.add(location); break; } } } }

  }
}
