import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService{

 Future<bool> isLocationAlreadyInList(DocumentSnapshot ds,String uidOfcurrentMapUser) async{
//  bool isExists = false;
 final  listLocationName = ds['loc_Name'];
 return await FirebaseFirestore.instance.collection('userDataCollection')
             .doc(uidOfcurrentMapUser)
            .collection('userWishListDataCollection')
            .where('toGoListedLocation',isEqualTo:listLocationName ).limit(1)
            .get().then((result) => result.docs.length > 0);
   }

   
 

//adding where to go List
  Future storeSelectedUserLocations(DocumentSnapshot ds,String uidOfcurrentMapUser) async{
//  final  listLocationName = 'working';
 final  listLocationName = ds['loc_Name'];
//  String currentUserId = await UserDatabaseService().getCurrentUserId();
//check this shold work
return await  FirebaseFirestore.instance.collection('userDataCollection')
            // .doc(userinMap.uid)
             .doc(uidOfcurrentMapUser)
            .collection('userWishListDataCollection')
            .add({
              'toGoListedLocation':listLocationName
            });
 }
}