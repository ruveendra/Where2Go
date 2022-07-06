//register
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:login_where2go/src/screens/login.dart';
import 'package:login_where2go/src/screens/verify.dart';
import 'package:login_where2go/src/services/auth_service.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email;
  String _password;
  String _userName;
   
  //  final auth = FirebaseAuth.instance;
   final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            child: Image(
              image: AssetImage('assets/done.png'),
              height: 300,
              width: 200,
            ),
          ),
          Padding(
             padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              keyboardType:TextInputType.name,
               decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.verified_user,
                  color: Color(0xff2470c7),
                ),
                hintText: 'Enter Your User Name',
              ),
              onChanged: (value){
                setState((){
                  _userName =value.trim();  
                });
              },
            ),
          ),
          Padding(
             padding: const EdgeInsets.only(bottom: 10),
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
        //  Row(children: <Widget>[
            Container(
              // h
              child: RaisedButton(
                color: Color(0xff2470c7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                //  padding: EdgeInsets.only(left: 50.0, right: 150.0),
                splashColor: Color(0xff2470c7),
                child: Text('Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 20,
                  ),
                ),
                onPressed:()=>_signUp(_email,_password,_userName),
              ),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
              TextButton(child:Text('Already have an Account? Let\' Sign-in'),onPressed:()=>Navigator.of(context)
               .push(MaterialPageRoute(
                 builder:(context) => LoginScreen(),
                ))
               ),
            ],
            ),
          ],)
        
        )
    );
  }

Future _signUp(String _email,String _password,String userName ) async{
    try{  
     dynamic result = await _auth.firebaseSignUp(_email, _password,_userName);

    //get userid from firebase
    // User user =result.user;
    // await UserDatabaseService(uid: user.uid).inputUserData(userName);
    //sucessful login 
    if(result!= null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder:(context)=>VerifyScreen() ));
    }
    else{
      String error= "Sign in Error.Null User";
      Fluttertoast.showToast(msg:error,gravity:ToastGravity.TOP);
    }
    }catch(e){
      Fluttertoast.showToast(msg:e.message,gravity:ToastGravity.TOP);
    }
}
// Future _signUp(String _email,String _password,String userName ) async{
//     try{  
//      dynamic result = await _auth.firebaseSignIn(email: _email, password: _password,userName:_userName );
//     //get userid from firebase
//     User user =result.user;
//     await UserDatabaseService(uid: user.uid).inputUserData(userName);
//     //sucessful login 
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder:(context)=>VerifyScreen() ));
//     }on FirebaseAuthException catch (error){
//       Fluttertoast.showToast(msg:error.message,gravity:ToastGravity.TOP);
//     }catch(e){
//       Fluttertoast.showToast(msg:e.message,gravity:ToastGravity.TOP);
//     }
// }

}