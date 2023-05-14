import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'Authenticate/login.dart';
import 'services/auth.dart';
import 'package:lab7/models/UserInfo.dart';
import 'package:lab7/screens/Videos.dart';
import 'package:lab7/screens/Player%20Comparison/Player%20Comparison.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:lab7/wrapper.dart';
import 'package:lab7/Authenticate/login.dart';

void main() async{
  final MaterialColor primaryColor = MaterialColor(
    0xFF1B5E20,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      StreamProvider<UserInfo?>.value(
        value:AuthService().userInfo,
        initialData: UserInfo("",true),
        child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor:Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white38,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0), // Example border radius
              borderSide: BorderSide(
                color: Colors.grey, // Example border color
                width: 1.0, // Example border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0), // Example border radius
              borderSide: BorderSide(
                width: 2.0, // Example border width when focused
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey, // Example hint text color
            ),
          ),
        ),
        routes: {'/home':(context) => home(),
          '/player_comparison':(context)=>MyPage(),
          // '/compare':(context)=>Compare(),
          // '/compare': (context) => Compare(),
          '/video':(context)=>UploadFilePage(),
          '/login':(context)=>MyLoginPage(title: "CricAce"),
        }
  ),
      ));
}