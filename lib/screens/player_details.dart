import 'package:flutter/material.dart';

class PlayerDetails extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  final String match;
  final String performance;
  // final String runs;
  final String points;
  final String classification;

  // final String average;

  const PlayerDetails({
    required this.name,
    required this.role,
    required this.image,
    required this.performance,
    required this.points,
    required this.classification,
    // required this.average,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    if (role=="Batsman"){
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Details',style: TextStyle(color:Colors.grey.shade300),),
      ),
      body: Container(

        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius:50,
                  backgroundImage:NetworkImage(
                    image,
                  ),
                ),
                SizedBox(width: 16.0),
                Text(
                      name,
                      softWrap: true,
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                SizedBox(height: 8.0,width:20),
                Image.asset(
                      'Assets/lahore.png',
                      height: 20,
                      width: 40,
                    ),
                  ],
                ),


            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Row(
                  children: [
                    Text(
                      'Match',
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      match,
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Runs',
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      performance,
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 70.0),
            Text("Strong and Weak Point of $name", style: TextStyle(color:Colors.white,fontSize:20)),
            SizedBox(height: 30.0),

            Image.network(
              points,
              height: 300,
              width: 800,
            ),

          ],
        ),
      ),
    );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Player Details',style: TextStyle(color:Colors.white),),

        ),
        body: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius:50,
                        backgroundImage: NetworkImage(
                          image,
                        ),
                      ),

                    SizedBox(width: 16.0),
                    Text(
                      name,
                      style: TextStyle(
                        color:Colors.grey,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0,width:20),
                    SizedBox(
                      width:40,
                      child: Image.asset(
                        'Assets/lahore.png',
                        height: 90,
                        width: 40,
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Matches',
                          style: TextStyle(
                            color:Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          match,
                          style: TextStyle(
                            color:Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Wickets',
                          style: TextStyle(
                            color:Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          performance,
                          style: TextStyle(
                            color:Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),

                SizedBox(height: 70.0),
                Text("Strong and Weak Point of $name", style: TextStyle(color:Colors.white,fontSize:20)),
                SizedBox(height: 30.0),

                Image.network(
                  points,
                  height: 300,
                  width: 400,
                ),
                SizedBox(height: 30.0),
                Text("Bowling Length Percentage of $name", style: TextStyle(color:Colors.white,fontSize:20)),
                SizedBox(height: 30.0),

                Center(
                  child: Image.network(
                    classification,
                    height: 350,
                    width: 400,

                  ),
                ),
              ],
            ),

          ),
        ),
      );
    }
  }
}
