import 'package:flutter/material.dart';
// import 'package:where2go/Services/class_package.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChoosePackage extends StatefulWidget {
  final data;
  final User currentListuser;
  ChoosePackage({this.data, this.currentListuser});
  @override
  _ChoosePackageState createState() => _ChoosePackageState();
}

//Requesting the data

class _ChoosePackageState extends State<ChoosePackage> {

  void getPackage(travelPlans){

    DocumentSnapshot data = travelPlans;

    Navigator.pushNamed(context,'/package', arguments: {

      'title':data['title'],
      'about': data['about'],
      'location':data['locations'],

    });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Travel Plans'),
        centerTitle: true,
        elevation: 0,

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('package_details').snapshots(),
        builder: (context,snapshot){
          if(snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemExtent: 170,
            itemBuilder: (context,index){
              DocumentSnapshot travelPlans = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:1.0, horizontal: 4.0 ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white70,
                    elevation: 5,
                    child: InkWell(
                      onTap: (){
                        getPackage(travelPlans);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            // padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 160,
                              width: 170,
                              // constraints: BoxConstraints(
                              //   maxWidth: MediaQuery.of(context).size.width * 0.4,
                              //   maxHeight: MediaQuery.of(context).size.width * 0.28,
                              // ),
                              child:ClipRRect(
                                borderRadius:BorderRadius.circular(15.0),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      travelPlans['img']
                                  ),
                                ),
                              ) ,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Text(
                                      travelPlans['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,

                                    ),

                                  ),
                                ),

                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 118,

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Flexible(
                                    flex: 2,
                                     child: Text(travelPlans['about'],
                                    // overflow: TextOverflow.ellipsis,

                                    style: TextStyle(
                                      fontSize: 12,
                                    ),),
                                  ),
                                ),


                              )
                            ],


                          )

                        ],
                      ),
                    ),

                  ),
                ),
              );
            },
          );
        },
      )
    );
  }
}



