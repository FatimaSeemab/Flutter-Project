import 'package:flutter/material.dart';

import '../Database/database.dart';
import 'player_details.dart';
class TeamDetailsPage extends StatefulWidget {
  final String teamName;

  const TeamDetailsPage({required this.teamName});

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  String path_to_team="";
  List<Player> playerList = [];
  Map<String, String> teamsList = Map.fromIterable(
    ['key1', 'key2'],
    key: (k) => k,
    value: (v) => "",
  );


  @override
  void initState() {

    super.initState();
    fetchPlayersList();
    fetchTeamsList();

  }
  fetchPlayersList() async {

    dynamic Players = await DatabaseManager().getPlayers();
    if (Players == null) {
      print("Unable to get teams data");
    }
    else {
      setState(() {
        for (MapEntry<String, Map<String, dynamic>> playerEntry in Players.entries) {
          Player player = Player(
            name: playerEntry.value['name'],
            role: playerEntry.value['role'],
            image: playerEntry.value['picture'],
            match: playerEntry.value['match'],
            performance:playerEntry.value['performance'],
            points:playerEntry.value['points']??"",
            classification:playerEntry.value['classification']??""
          );

          if(widget.teamName==playerEntry.value['teamName'])
          {playerList.add(player);
          print(playerList);
          }
        }

      });

    }
  }

  fetchTeamsList() async {
    dynamic resultant = await DatabaseManager().getTeamsData();
    if (resultant == null) {
      print("Unable to get teams data");
    }
    else {
      setState(() {
        print(resultant);
        teamsList = resultant;

      });

    }
  }
  @override
  Widget build(BuildContext context) {
    for (var team in teamsList.entries) {
      if (team.key == widget.teamName) {
        path_to_team = team.value;
      }
    }
    // if (widget.teamName=="Lahore Qalandars") {
    return Scaffold(
      appBar: AppBar(title: Text(
          "Player Statistics", style: TextStyle(color: Colors.grey.shade300))),
      body: Container(

        child: ListView.builder(
          itemCount: playerList.length,
          itemBuilder: (BuildContext context, int index) {
            final player = playerList[index];
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayerDetails(
                            name: player.name,
                            image: player.image,
                            match: player.match,
                            role: player.role,
                            performance: player.performance,
                            points: player.points,
                            classification: player.classification,

                          ),
                    ),
                  );
                },
                child: Card(
                  color: Colors.grey.shade900,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(path_to_team, width: 60, height: 60,),
                            Text(
                              player.name,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              player.role,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),

                        Image.network(
                          player.image,
                          height: 200.0,
                          width: 120.0,
                        ),
                      ],
                    ),

                  ),

                ));
          },
        ),

      ),

    );
  }
  }
// }

class Player {
  final String name;
  final String role;
  final String image;
  final String performance;
  // final String  no_of_matches;
  // final String  strike_rate;
  final String  match;
  final String points;
  final String classification;

  const Player({
    required this.name,
    required this.role,
    required this.image,
    required this.performance,
    required this.match,
    // required this.strike_rate,
    // required this.average,
    required this.points,
    required this.classification

  });
}


