import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_where2go/src/screens/AdminScreen/AdminScreen.dart';

import 'package:login_where2go/src/screens/reset.dart';


import '../services/auth_service.dart';
import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  // final auth = FirebaseAuth.instance;
final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    
          child: Scaffold(
            resizeToAvoidBottomInset: false,
         body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('assets/done.png'),
                height: 380,
                width: 300,
              ),
            ),
            Container(
               //padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType:TextInputType.emailAddress,
                 decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff2470c7),
                  ),
                  hintText: 'Enter Your Email address',
                ),
                onChanged: (value){
                  setState((){
                    _email =value.trim();  
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xff2470c7),
                                  
                  ),
                  hintText: 'Enter Your Password Here',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
            ),
           Column
           (children: <Widget>[
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Container(
                    width:300,
                    child: RaisedButton(
                      color: Color(0xff2470c7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      //padding: EdgeInsets.only(left: 50.0, right: 150.0),
                      splashColor: Color(0x40DA9D),
                      child: Text(
                        'Sign in',
                       textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 20,
                        ),
                      ),
                      onPressed:()async
                      {
                        await _signIn(_email,_password);
                      }
                    ),
                  ),
                ],
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                onPressed:()=>Navigator.of(context)
                 .push(MaterialPageRoute(
                   builder:(context) => ResetScreen(),
                  )
                  )
                 ),],),
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text(
                      'Don\'t have an Account? Signup Here',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ))
               ),
              ],
            ),
            ],),
          ]),
         ),
         ),
      
    );
  }

_signIn(String email,String password) async{ 
  final User user =await _auth.logInWithEmail(email,password);
      if(user!= null){
        //admin 
        if(user.uid == 'Z1kvbYCIm2fi7xfpFQrlagft55G2'){
       Navigator.of(context).pushReplacement(MaterialPageRoute(
                     builder:(context)=>AdminScreen()));
        }
        else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
                     builder:(context)=>HomeScreen()));
        }        
      }else{
        String loginerror = 'Unable to Login';
        Fluttertoast.showToast(msg:loginerror,gravity:ToastGravity.TOP);
       print(' cannot log in');
      }
}

}


