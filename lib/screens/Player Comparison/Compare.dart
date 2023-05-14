import 'package:flutter/material.dart';
import 'package:lab7/Database/database.dart';
class Compare extends StatefulWidget {
  final String player1;
  final String player2;

  const Compare({
    required this.player1,
    required this.player2,

  });

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  String Image1="";
  String Image2="";

  void initState() {
    super.initState();
    getPics();
    // Image1,Image2 = await DatabaseManager().getZonesPic(widget.player1);
    // Image2 = await DatabaseManager().getZonesPic(widget.player2);
  }
  getPics() async{
    Image1 = await DatabaseManager().getZonesPic(widget.player1);
    Image2 = await DatabaseManager().getZonesPic(widget.player2);
    setState(() {
      if(Image1!=null){
        Image1=Image1;
      }
      if(Image2!=null){
        Image2=Image2;
      }
    });


    }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor:Colors.black12,
      appBar: AppBar(
        title: Text('Compare Players',style: TextStyle(
          color:Colors.grey.shade300,

        ),),
          backgroundColor:Colors.green.shade900
      ),
       body: Container(
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,width:20),
              Text(
                'Comparing ${widget.player1} vs ${widget.player2}',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade300
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              Text(widget.player1, style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500
              )),
              SizedBox(height: 10),
                Text("strong and weak zones", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500
                ),
              ),
              SizedBox(height: 10),
              Image.network(
                Image1,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10),
              Text(widget.player2, style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500
              ),
              ),
              SizedBox(height: 10),
              Text("strong and weak zones", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500
              ),
              ),
              SizedBox(height: 10),
              Image.network(
                Image2,
                width: 200,
                height: 250,
              ),
                    ],

              ),
       ),
    );
  }
}
