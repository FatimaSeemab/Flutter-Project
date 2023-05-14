import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext build){
    return Container(
      color: Colors.black87,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.green.shade700,
          size: 50.0,
        ),
      ),
    );
  }
}