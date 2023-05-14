import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {


  Future<Map<String, String>> getTeamsData() async {
    Map<String, String> teamsData = {};

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Teams').get();

    snapshot.docs.forEach((doc) {
      String teamName = doc.get('Team Name');
      String picture = doc.get('Picture');
      teamsData[teamName] = picture;
    });
    // print(teamsData);
    return teamsData;
  }

  Future<Map<String,Map<String, String>>>getZones() async {
    Map<String, Map<String,String>> ZonesData = {};

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Zones').get();
    int i=0;
    snapshot.docs.forEach((doc) {
      print(doc);
      Map<String,String> zones=
      {
         "player_name" : doc.get('Player Name'),
         "picture" : doc.get('Zones')

      };
      ZonesData['player'+i.toString()]=zones;
      i++;
    });

    print(ZonesData);
    return ZonesData;
  }

  Future<String> getZonesPic(String player) async {

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Zones').get();
    int i=0;
    String picture="";
    snapshot.docs.forEach((doc) {
      if (doc.get('Player Name')==player){
        picture=doc.get('Zones')??"";
      }
    });
    return picture;
  }

  Future<Map<String, Map<String, dynamic>>> getPlayers() async {
    Map<String, Map<String, dynamic>> Players={
      'player1': {
        'name': 'John',
        'teamName': 'Team A',
        'picture': 'https://example.com/picture1.jpg',
        'role': 'Forward',
      },
      'player2': {
        'name': 'Jane',
        'teamName': 'Team B',
        'picture': 'https://example.com/picture2.jpg',
        'role': 'Midfielder',
      },
    };
    int i=0;

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Player').get();


    snapshot.docs.forEach((doc) {

      Map<String, dynamic> newPlayerData = {
        'name': doc.get('Player_Name'),
        'teamName': doc.get('Team Name'),
        'picture': doc.get('Picture'),
        'role': doc.get('Role'),
        'points':doc.get('Points'),
        'classification':doc.get('Classification'),
        'match':doc.get('Matches'),
        'performance': doc.get('Performance'),
        // doc.get('Performance'),

      };

      Players['player'+i.toString()]=newPlayerData;
      i++;
    });

    return Players;
  }

  Future<Map<String, Map<String, dynamic>>> getVideos() async {


    Map<String, Map<String, dynamic>> Videos={

    };
    int i=0;
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Videos').get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> videoData = {
        'userid': doc.get('userid'),
        'url': doc.get('url'),
        'ball_type': doc.get('ball_type'),
        'bat_type':doc.get('bat_type'),
        'video':doc.get('video_name')

      };
      Videos["video"+(i.toString())]=videoData;

      // print(Videos);
      i++;
    });
    print(Videos);
    return Videos;
  }

  Future<void> deleteCollection() async {

    CollectionReference<Map<String, dynamic>> collectionRef =
    FirebaseFirestore.instance.collection("Videos");


    QuerySnapshot<Map<String, dynamic>> snapshot;
    do {
      snapshot = await collectionRef.limit(2).get();
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } while (snapshot.size > 0);
  }
}