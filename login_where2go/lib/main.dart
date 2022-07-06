
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_where2go/src/models/common.dart';

import 'package:login_where2go/src/screens/mapScreen/mapscreen.dart';
 import 'package:login_where2go/src/screens/login.dart';
import 'package:login_where2go/src/screens/package_details.dart';
 import 'package:login_where2go/src/services/auth_service.dart';
import 'package:login_where2go/src/models/slider.dart' as sliderWidget;

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   //need this later uncomment
   await Firebase.initializeApp();
  runApp(App());
}
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title:'LoginApp',
        theme:ThemeData(
          accentColor:Colors.orange,
          primarySwatch: Colors.blue 
          ),
          home: MyHomePage(),
          //  GoogleMapsScreen(),

          //  SignUpScreen(),
          routes:<String,WidgetBuilder>{
            //'/home':(BuildContext context)=>HomeScreen(),
            '/package': (context) => PackageDetails(),
          }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> getCarousalItems() async {

    List<DocumentSnapshot> carousalList = [];
    sliderItems = [];

    final CollectionReference carousalCollection = FirebaseFirestore.instance.collection("carousal");

    carousalList = (await carousalCollection.get()).docs;

    for(int i = 0; i < carousalList.length; i++){
      // sliderItems.add(new sliderWidget.Slider(image: carousalList[i]['url'], button: "test", description: carousalList[i]['desc']));
      
    }
    print(sliderItems.length);

    return 'success';
  }

  Future<void> continueToLogin() async {
    await getCarousalItems().then((value){setState(() {});}).then((value){
      Timer(Duration(seconds: 2), () => Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => LoginScreen())));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    continueToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30,),
                  child: Text(
                    "Where2Go",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 60
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

