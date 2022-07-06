import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteLocation extends StatefulWidget {
  @override
  _DeleteLocationState createState() => _DeleteLocationState();
}

class _DeleteLocationState extends State<DeleteLocation> {

  getLocations(AsyncSnapshot<QuerySnapshot> snapshot) {
   return snapshot.data.docs.map((doc) => Padding(
     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
     child: Container(
       color: Colors.blue,
       child: Padding(
         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(doc['loc_Name'], overflow: TextOverflow.fade, style: TextStyle(color: Colors.white),),
             IconButton(icon: Icon(Icons.delete_rounded, color: Colors.white,), onPressed: () {
               showDialog(
                 context: context,
                 builder: (context) => AlertDialog(
                   title: Text(
                     'Confirm Deletion',
                     textAlign: TextAlign.center,
                   ),
                   content: Text(
                     'You want to delete this Location?',
                     textAlign: TextAlign.center,
                   ),
                   actions: <Widget>[
                     TextButton(
                       child: Text('No'),
                       onPressed: () {
                         Navigator.pop(context, true);
                       },
                     ),
                     TextButton(
                       child: Text('Yes'),
                       onPressed: () async {
                         await FirebaseFirestore.instance.collection('locations').doc(doc.id).delete().then((value) {
                           setState(() {});
                           Navigator.pop(context, true);
                         });
                       },
                     ),
                   ],
                 ),
               );
             })
           ],
         ),
       ),
     ),
   )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return ListView(
              children: getLocations(snapshot),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
