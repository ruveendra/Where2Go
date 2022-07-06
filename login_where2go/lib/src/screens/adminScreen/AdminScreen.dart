import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/screens/adminScreen/AddPackage.dart';
import 'package:login_where2go/src/screens/login.dart';

import '../deleteLocation.dart';
import 'AddLocation.dart';



class AdminScreen  extends StatelessWidget {

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _url = new TextEditingController();
  final TextEditingController _desc = new TextEditingController();
  final TextEditingController _longitude = new TextEditingController();
  final TextEditingController _latitude = new TextEditingController();
  List<String> locName;

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
    );

    TextStyle commonTextStyle = Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).accentColor);

    final auth = FirebaseAuth.instance;


    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                auth.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=> LoginScreen()));
              },
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward),
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView(
              children: [

                // HomeSliderWidget(),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () async {
                      // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> GoogleMapsScreen(userinMap:user)));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder:(context)=>AddLocation()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width/100*90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            height: 80,
                            width: 100,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/image1.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Add Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () async {
                      // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Where2GoList(currentListuser:user) ));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder:(context)=>AddPackage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width/100*90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            height: 80,
                            width: 100,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/image2.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Add Package",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () async {
                      // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> GoogleMapsScreen(userinMap:user)));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteLocation()
                      ));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width/100*90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            height: 80,
                            width: 100,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/image1.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Delete Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),




              ],
            ),
          )
        ],
      ),
    );
  }
}