import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class  UserDatabaseService{
final String uid;
final FirebaseAuth _auth = FirebaseAuth.instance;
//assigning document id value from database to uid
UserDatabaseService({this.uid});
//userData collection

final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('userDataCollection');
//input user Data
//this is triggered during user registration
Future inputUserData(String userName) async{
  return await  userDataCollection.doc(uid).set({
    'userName':userName
  });
}

Future<String> getCurrentUserId() async {
    final User user =  _auth.currentUser;
    final uid = user.uid.toString();
    return uid;
    //print(uemail);
  }


 }