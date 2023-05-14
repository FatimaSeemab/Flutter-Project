import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab7/models/UserInfo.dart' as user;
import 'dart:async';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

 user.UserInfo? _userFromFirebaseUser(User? userdetails){
   if (userdetails == null) {
     return null;
   } else {
     return user.UserInfo(userdetails.uid,userdetails.isAnonymous);
   }
  }

  Stream<user.UserInfo?> get userInfo {
    return _auth.authStateChanges().map((User? user) =>
        _userFromFirebaseUser(user));
  }

  Future signInAnon() async{
    try{
      UserCredential result=  await _auth.signInAnonymously();
      User? user_det=result.user;

      return _userFromFirebaseUser(user_det);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email,String password) async{
   try{
     UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
     User? user_det=result.user;
     return _userFromFirebaseUser(user_det);
   }
   catch(e){
     print(e.toString());
     return null;
   }

  }
  Future SignInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user_det=result.user;
      return _userFromFirebaseUser(user_det);
    }

    catch(e){
      print(e.toString());
      return null;
    }

  }






  Future<void> signOut() async{
    try{
      await _auth.signOut();
      print("User sign out successfully");

    }
    catch(e){
      return null;
    }
  }


}