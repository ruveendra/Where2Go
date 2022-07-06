import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_where2go/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//get data from user data and show it off

class Where2GoList extends StatefulWidget {
  final data;
  final User currentListuser;
  Where2GoList({this.data, this.currentListuser});
  @override
  _Where2GoListState createState() => _Where2GoListState();
}

class _Where2GoListState extends State<Where2GoList> {
  @override
  Widget build(BuildContext listcontext) {
    //   final firebaseAuth =Provider.of<FirebaseAuth>(context);
    // final String userid= (firebaseAuth.currentUser).uid;
    // child:Text(widget.currentListuser.uid),
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: " Return to MapScreen",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text('Where2goList'),
            ),
            body: StreamBuilder(
             // if(listedLocation.data == null) return CircularProgressIndicator();
             
              stream: FirebaseFirestore.instance
                  .collection('userDataCollection')
                  .doc(widget.currentListuser.uid)
                  .collection('userWishListDataCollection')
                  .snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot listedLocation = snapshot.data.docs[index];

                        // return ListTile(
                        //   title:Text('${listedLocation['toGoListedLocation']}'),
                        // );
                        return Dismissible(
                          key: Key(listedLocation['toGoListedLocation']),
                          child: InkWell(
                            // onTap: () {
                            //   print("${listedLocation[index]} clicked");
                            // },
                              child: ListTile(
                                  title: Text('${listedLocation['toGoListedLocation']}'),
                              ),
                          ),

                          // background: slideRightBackground(),
                          background: slideLeftBackground(),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${listedLocation['toGoListedLocation']}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Delete", style: TextStyle(color: Colors.red),),
                                          onPressed: () {
                                            setState(() {
                                              listedLocation.reference.delete();
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            }

                          },
                        );
                      });
                }else{
                  return Container();
                }
              },
            )));
  }
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
