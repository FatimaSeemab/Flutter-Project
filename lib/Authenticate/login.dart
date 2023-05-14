import 'package:flutter/material.dart';
import 'package:lab7/services/auth.dart';
import '../screens/home.dart';
import 'package:lab7/screens/Player%20Comparison/Player%20Comparison.dart';
import '../screens/Player Comparison/Compare.dart';
import '../screens/Videos.dart';
import 'package:flutter/gestures.dart';
import 'package:lab7/Authenticate/register.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lab7/shared/loading.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class MyLoginPage extends StatefulWidget {
  MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage> {
  bool? _isChecked = false;
  bool _obscureText = true;
  bool loading = false;


  Future<List<String>> getDownloadUrls(String folderName) async {
    List<String> downloadUrls = [];

    final Reference storageRef = FirebaseStorage.instance.ref().child(folderName);
    final ListResult result = await storageRef.listAll();

    for (final Reference ref in result.items) {
      final String downloadUrl = await ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }

  String error = "";
  final FirebaseAuth fireabse_auth = FirebaseAuth.instance;
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  Future<void> _resetPassword(String email) async {
    return fireabse_auth.sendPasswordResetEmail(email: email);
  }

  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'Assets/backgroundimage.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Let's Explore the ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Cricket World',
                                  style: TextStyle(
                                    color: Colors.green, // change color to green
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Together',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            'Please enter your username and password to continue',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                      width: 300,
                      child: Column(children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: userIDController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person,color: Colors.black87,),
                          ),
                          style: TextStyle(color: Colors.black87),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email address';
                            }
                            if (value != null) {
                              final bool isValid =
                                  EmailValidator.validate(value);
                              if (!isValid) {
                                return 'Please enter a valid email address';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50.0),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock,color:Colors.black87),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                // Toggle icon based on password visibility state
                                onPressed: () {
                                  setState(() {
                                    _obscureText =
                                        !_obscureText; // Invert the password visibility state
                                  });
                                },
                              )),
                          style: TextStyle(color: Colors.black87),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Please enter a password with at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              // Set the initial value of the checkbox,
                              activeColor: Colors.white70,
                              onChanged: (value) {
                                setState(() {
                                  // Use setState() to update the checkbox state
                                  _isChecked = value;
                                });
                              },
                            ),

                            SizedBox(width: 80.0),
                            GestureDetector(
                              onTap: () {
                                _resetPassword(
                                    userIDController.value.toString());
                              },
                              child: Text("Forgot Password ?",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.end),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await auth.SignInWithEmailAndPassword(
                                          userIDController.text,
                                          passwordController.text);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          "Could not sign in with those credentials";
                                      // loading = false;
                                    });
                                  }
                                  else{
                                    final List<String> downloadUrls = await getDownloadUrls('Player Pictures');
                                    print(downloadUrls);

                                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>home()));

                                  }
                                }
                              }),
                        ),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.green.shade700, fontSize: 16),
                        )
                        // Declare a boolean variable to keep track of checkbox state
                      ])),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account, ",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'register',
                        style: TextStyle(
                          color: Colors.purple[300],
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Sign In as, ",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'guest',
                        style: TextStyle(
                          color: Colors.purple[300],
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            dynamic result = await auth.signInAnon();
                            if (result == null) {
                              print("error signing in");
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
                              print("Signed in ");
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
