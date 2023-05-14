import 'package:flutter/material.dart';
import 'package:lab7/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:lab7/Authenticate/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lab7/screens/home.dart';
import '../shared/loading.dart';


class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}
class RegisterState extends State<Register> {
  String error="";
  final  AuthService auth=AuthService();
  final _formKey=GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureText_confirm=true;

  TextEditingController userIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          SizedBox(height:30 ,),
          Form(
            key:_formKey,
            child: Container(
                width:300,
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: userIDController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person,color:Colors.black87),


                        ),
                        style: TextStyle(color: Colors.black87),
                        validator: (value) {
                          if (value==null || value.isEmpty ) {
                            return 'Please enter a valid email address';
                          }
                          if (value != null){
                            final bool isValid = EmailValidator.validate(value);
                            if (!isValid){
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
                              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility), // Toggle icon based on password visibility state
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText; // Invert the password visibility state
                                });
                              },
                            )
                        ),
                        style: TextStyle(color: Colors.black87),
                        validator: (value) {
                          if (value==null || value.length < 6) {
                            return 'Please enter a password with at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50.0),
                      TextFormField(
                        obscureText: _obscureText_confirm,
                        controller: confirmpasswordController,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',

                            prefixIcon: Icon(Icons.lock,color:Colors.black87),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText_confirm ? Icons.visibility_off : Icons.visibility), // Toggle icon based on password visibility state
                              onPressed: () {
                                setState(() {
                                  _obscureText_confirm = !_obscureText_confirm; // Invert the password visibility state
                                });
                              },
                            )
                        ),
                        style: TextStyle(color: Colors.black87),
                        validator: (value) {
                          if ( value!=passwordController.text ) {
                            return 'Both Passwords don"t match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),

                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  // loading = true;
                                });
                                dynamic result = await auth
                                    .registerWithEmailAndPassword(
                                    userIDController.text,
                                    passwordController.text);
                                if (result == null) {
                                  setState(() {
                                    error ="please supply valid value of email and password";
                                    // loading = false;
                                  });

                                }
                                else{
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => home(

                                      ),
                                    ),
                                  );

                                }
                              }
                            }
                        ),
                      ),
                      Text(error,
                      style: TextStyle(color:Colors.green.shade700,fontSize: 16),)
                      // Declare a boolean variable to keep track of checkbox state

                    ]
                )),
          ),
          Spacer(),

          RichText(
            text:TextSpan(
              text: "Already have an account,",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' Sign In',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginPage(title: "CricAce")),
                      );

                    },
                ),],
            )
            ,)
          ,
        ],
      ),
    );
  }
}
