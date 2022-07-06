import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:login_where2go/src/screens/verify.dart';
import 'home.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
 
   final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Where2Go Reset Password')
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType:TextInputType.emailAddress,
              decoration:InputDecoration(
                hintText:'Email',
              ),
              onChanged: (value){
                setState((){
                  _email =value.trim();  
                });
              },
            ),
          ),
          Row(children:<Widget> [
           RaisedButton(
             color:Theme.of(context).accentColor,
             child:Text('Reset Password'),
             onPressed:(){
               auth.sendPasswordResetEmail(email : _email);
                Navigator.of(context).pop();
             }
           )
            ]
            ),
          ],)
        );
      
    
  }
}