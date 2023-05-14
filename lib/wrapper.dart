import 'package:flutter/cupertino.dart';
import 'package:lab7/Authenticate/login.dart';
import 'package:lab7/models/UserInfo.dart';
import 'package:provider/provider.dart';
import 'package:lab7/screens/home.dart';
import 'package:lab7/services/auth.dart';
class Wrapper extends StatelessWidget
{

  @override
  Widget build(BuildContext context){

    final user=Provider.of<UserInfo?>(context);

    print(user?.uid);
    if (user!=null)
    { if(user.uid.isEmpty)
     {
      print("No user");
      return MyLoginPage(title: 'CricAce');
     }
      else{
      return home();
     }
    }
    else{
      print("No user");
      return MyLoginPage(title: 'CricAce');
    }

  }
}