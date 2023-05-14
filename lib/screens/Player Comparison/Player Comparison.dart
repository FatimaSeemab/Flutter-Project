import 'package:flutter/material.dart';
import '../../Authenticate/login.dart';
import 'package:lab7/Database/database.dart';
import 'package:lab7/screens/Player Comparison/Compare.dart';
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String? _player1;
  String? _player2;


  void initState(){
    super.initState();
    fetchZones();

  }

  List<Zones> ZonesList=[];

  fetchZones() async {

    dynamic ZonesData = await DatabaseManager().getZones();
    if (ZonesData == null) {
      print("Unable to get teams data");
    }
    else {
      setState(() {
        for (MapEntry<String, Map<String,String>> zone_entry in ZonesData.entries) {
          Zones zone = Zones(
              name: zone_entry.value['player_name']??"",
              picture: zone_entry.value['picture']??"",

          );
          ZonesList.add(zone);

        }

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Comparison of Players",style:TextStyle(color:Colors.grey.shade300))
      ),
      body: Container(
        child: Stack(
          children: [
            Opacity(
              child: Image.asset(
                'Assets/backgroundimage.png', // replace with your background image path
              ),
              opacity: 0.3,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Compare the Performance of Two Players',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Select the player of your choice',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width:290,
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey.shade500,
                            value: _player1,

                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            items: ZonesList.map((player) {
                              return DropdownMenuItem<String>(
                                value: player.name,
                                child: Text(player.name, style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _player1 = value;
                              });
                            },
                          ),
                        )],
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Container(
                      width:290,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.grey.shade400,
                          value: _player2,
                          decoration: InputDecoration(
                            border: InputBorder.none,

                          ),
                          items: ZonesList.map((player) {
                            return DropdownMenuItem<String>(
                              value: player.name,
                              child: Text(player.name, style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _player2 = value;

                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                          ),
                        child: Text(
                          'Player Comparison',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Compare(
                                        player1: _player1??"",
                                        player2: _player2??"",
                                      )
                              )
                          );
                        } // add your button on pressed functionality here
                        )
                      ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Zones {
  final String name;
  final String picture;

  const Zones({
    required this.name,
    required this.picture,

  });
}