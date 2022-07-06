import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/screens/login.dart';
class AddPackage  extends StatelessWidget {

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _url = new TextEditingController();
  final TextEditingController _desc = new TextEditingController();
  final TextEditingController _longitude = new TextEditingController();
  final TextEditingController _latitude = new TextEditingController();
  final TextEditingController _locName = new TextEditingController();


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
        title: Text('Add Package'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=> LoginScreen()));
              },
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward),
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                            border: commonBorder,
                            focusedBorder: commonBorder,
                            enabledBorder: commonBorder,
                            labelText: 'Name',
                            labelStyle: commonTextStyle,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: _url,
                          decoration: InputDecoration(
                            border: commonBorder,
                            focusedBorder: commonBorder,
                            enabledBorder: commonBorder,
                            labelText: 'Image URL',
                            labelStyle: commonTextStyle,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: _desc,
                          decoration: InputDecoration(
                            border: commonBorder,
                            focusedBorder: commonBorder,
                            enabledBorder: commonBorder,
                            labelText: 'Description',
                            labelStyle: commonTextStyle,
                          ),
                          maxLines: 5,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: _locName,
                          decoration: InputDecoration(
                            border: commonBorder,
                            focusedBorder: commonBorder,
                            enabledBorder: commonBorder,
                            labelText: 'Location Name',
                            labelStyle: commonTextStyle,
                          ),
                          maxLines: 5,
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: ,
                      //
                      // ),

                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: TextFormField(
                      //     controller: _latitude,
                      //     decoration: InputDecoration(
                      //       border: commonBorder,
                      //       focusedBorder: commonBorder,
                      //       enabledBorder: commonBorder,
                      //       labelText: 'Latitude',
                      //       labelStyle: commonTextStyle,
                      //     ),
                      //     maxLines: 1,
                      //   ),
                      // ),
                      //
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: TextFormField(
                      //     controller: _longitude,
                      //     decoration: InputDecoration(
                      //       border: commonBorder,
                      //       focusedBorder: commonBorder,
                      //       enabledBorder: commonBorder,
                      //       labelText: 'Longitude',
                      //       labelStyle: commonTextStyle,
                      //     ),
                      //     maxLines: 1,
                      //   ),
                      // ),


                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        width: double.infinity,
                        child: MaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: StadiumBorder(),
                          color: Theme.of(context).backgroundColor,
                          child: Text(
                            'SUBMIT',
                            style: Theme.of(context).textTheme.headline6,
                          ),

                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              await FirebaseFirestore.instance.collection('package_details').doc().set({
                                'title': _name.text,
                                'img': _url.text,
                                'about': _desc.text,
                                'locations':_locName,
                                // 'loc_Coords': GeoPoint(double.parse(_latitude.text), double.parse( _longitude.text)),
                              }).then((value) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Upload Completed',
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('close'),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}