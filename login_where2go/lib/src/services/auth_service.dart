import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'userdatabase.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    Stream<User> get onAuthStateChanged =>
          _firebaseAuth.authStateChanges().map((User user) => user);
    // Stream<String> get onAuthStateChanged =>
    //       _firebaseAuth.authStateChanges().map((User user) => user.uid);
// Stream<User> get user{
//   return _firebaseAuth.authStateChanges();
// }
    String userID; 
    //sign up /register 
    Future firebaseSignUp(String _email,String _password,String userName) async{
        try{  
          UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _password);
          //get userid from firebase
          User user = result.user;

          await result.user.updateProfile(
            displayName: userName,
          ).then((value) async {
            await result.user.reload();
          });
          final currentUser = await getCurrentUser();
          await UserDatabaseService(uid: user.uid).inputUserData(userName);
        return currentUser;
        //sucessful login 
        //  Navigator.of(context).pushReplacement(MaterialPageRoute(
        //              builder:(context)=>VerifyScreen() ));
        }on FirebaseAuthException catch (error){
          Fluttertoast.showToast(msg:error.message,gravity:ToastGravity.TOP);
          return null;
        }
    }
    //update 
    //code---------q

    //Sign_in
    Future logInWithEmail(String email ,String password) async{
        try{  
         
          UserCredential result  = await _firebaseAuth.signInWithEmailAndPassword(email: email, password:password);
            User user = result.user;
            //getting loggin as user with userid
            userID=user.uid;
            return user;
            //sucessful loginc
          }on FirebaseAuthException catch (error){
            Fluttertoast.showToast(msg:error.message,gravity:ToastGravity.TOP);
            return null;
            //return null;
          }
    }

    Future<User> getCurrentUser() async {
      User user = _firebaseAuth.currentUser;
      return user;
    }

//signout
  signOut(){
    _firebaseAuth.signOut();
  }

}