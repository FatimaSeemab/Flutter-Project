import 'package:flutter/material.dart';
import 'package:lab7/services/auth.dart';
import 'team_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:lab7/models/UserInfo.dart'as User ;
import '../Authenticate/login.dart';
import 'package:lab7/Database/database.dart';

class home extends StatefulWidget{

  home();

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  AuthService _auth = AuthService();
  Map<String, String> teamsList = Map.fromIterable(
    ['key1', 'key2'],
    key: (k) => k,
    value: (v) => "",
  );

  @override
  void initState() {
    super.initState();
    fetchTeamsList();
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
    final user = Provider.of<User.UserInfo?>(context);
    bool anonymous = false;
    if (user != null) {
      anonymous = user.isAnonymous;
    }

    List<Widget> teamCards = [];
    for (var team in teamsList.entries) {

      teamCards.add(
        TeamCard(
          teamName: team.key,
          teamImage: team.value,
        ),);
        teamCards.add(
            SizedBox(height: 15),
          );

    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,

                title: Padding(
                  child: Text("CricAce", style: TextStyle(color: Colors.white,fontSize: 20)),
                  padding: const EdgeInsets.only(left:20.0),
                ),
                actions: <Widget>[
                  ElevatedButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Log out'),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  MyLoginPage(title: "CricAce"),
                      ),);
                    },
                  ),
                ]
            ),
            body: SingleChildScrollView(
                child: Container(
                    child: Column(
                        children: [
                          Image.asset('Assets/backgroundimage.png'),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text(
                                "Select Team",
                                style: TextStyle(
                                    color: Colors.grey.shade100, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: teamCards.length >= 6 ? teamCards.sublist(0, 6) : [],
                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  children: teamCards.sublist(6,),
                                ),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                anonymous?
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 120.0,vertical: 10),
                                  child: Center(
                                    child: SizedBox(
                                      width: 180,
                                      height: 50,
                                      child: Center(child:ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green.shade900,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              "/player_comparison");
                                        },
                                        child: Text(
                                            "Player Comparison",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 18)
                                        )
                                      ),
                                      ),
                                    ),
                                  ),
                                ):
                                  Center(
                                    child: SizedBox(
                                      width: 180,
                                      height: 50,
                                      child:ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green.shade900,
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                "/player_comparison");
                                          },
                                          child: Text(
                                              "Player Comparison",
                                              style: TextStyle(color: Colors.white,

                                                  fontSize: 18)
                                          )
                                      ),
                                      ),
                                  ),
                                SizedBox(width:5,),
                                Visibility(
                                  visible: !anonymous,

                                    child: SizedBox( width: 180,
                                      height:50,

                                      child: ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green.shade900,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/video");
                                        },
                                        child: Text(
                                            "Upload Video",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18)
                                        ),
                                      ),

                                  ),
                                ),
                              ]
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}

class TeamCard extends StatelessWidget {
  final String teamName;
  final String teamImage;

  const TeamCard({
    required this.teamName,
    required this.teamImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamDetailsPage(teamName: teamName),
          ),
        );
      },
      child: Card(
        child: Container(
          color: Colors.grey.shade900,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
               Expanded(
                  child: Container(
                    child: Text(
                      teamName,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,

                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 7),
               Image.network(
                   // 'https://drive.google.com/uc?export=view&id=1A2uu6uwt9qGOUGCfzJbA9kjauw5fqAbw',
                    teamImage,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

