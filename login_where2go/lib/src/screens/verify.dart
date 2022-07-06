import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';//timer

import  'home.dart';



class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  void initState(){ 
    user = auth.currentUser;
    user.sendEmailVerification();
      //givig 5 secs to verify adddress
      timer = Timer.periodic(Duration(seconds:5), (timer){
        checkEmailVerified();
      });
      super.initState();
  } 
//whether email verification working or not timer get cancelled
@override
void dispose(){
  timer.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text(
        'A verification email has been sent to ${user.email} '
      ),)
    );
  }

  Future <void>checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen())
      );
    }
  }
}