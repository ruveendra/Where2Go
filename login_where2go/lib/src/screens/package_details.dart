import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_place/google_place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class PackageDetails extends StatefulWidget {



  @override
  _PackageDetailsState createState() => _PackageDetailsState();

}

class _PackageDetailsState extends State<PackageDetails>  {

  Completer<GoogleMapController> _controller= Completer();

  Map data={};

  List <String> img=[];
  List <double> lat=[];
  List <double> long=[];
  List <String> title=[];
  List <Marker> allMarkers=[];
  List <Widget> boxes=[];
  double zoomVal=5.0;

  //get markers

  getMarkers(BuildContext context){
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    for(int i=0; i<data['location'].length;i++){
      FirebaseFirestore.instance
          .collection('locations')
          .where('loc_Name', isEqualTo: data['location'][i])
          .get()
          .then((result){
        if(result.docs.isNotEmpty){
          setState(() {
            allMarkers.add(Marker(
              markerId: MarkerId('$i'),
              draggable: false,
              position: LatLng(result.docs[0]['loc_Coords'].latitude,result.docs[0]['loc_Coords'].longitude),

            ));

          });
          // print(data['location'].length);
        }
      });
    }
  }

  //Get Details

  getDetails(BuildContext context){
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    for(int i=0; i<data['location'].length;i++){
      FirebaseFirestore.instance
          .collection('locations')
          .where('loc_Name', isEqualTo: data['location'][i])
          .get()
          .then((result){
        if(result.docs.isNotEmpty){
          setState(() {
            img.add(result.docs[0]['loc_Img']);
            lat.add(result.docs[0]['loc_Coords'].latitude);
            long.add(result.docs[0]['loc_Coords'].longitude);
            title.add(result.docs[0]['loc_Name']);

          });

        }
      });
      print(title[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;



    //Google Map

    Widget _googleMap(BuildContext context) {


      return Container(
        height:350.0 ,
        child:GoogleMap(

          mapType: MapType.normal,
          markers: Set.from(allMarkers),
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            zoom: 7.0,
            target: LatLng(7.2906,80.6337),
          ),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);getMarkers(context);
          },


        ) ,

      );

    }

    //Google map controller

    Future <void> gotoLocation(double lat,double long) async {
      final GoogleMapController controller=await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 15,tilt: 50.0,bearing: 45.0)));

    }

// Locations Details Pop-up

    void locDetails(name){






      // StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('locations').where('loc_Name', isEqualTo:name).snapshots(),
      //   builder: (context,snapshot){
      //     if(snapshot.data == null) return CircularProgressIndicator();
      //     DocumentSnapshot locDetails = snapshot.data.docs[0];
      //     return Navigator.pushNamed(context,'/package')}
      //
      // );

    }

 //Location Information Box

    Widget myDetailsContainer1(String name, String image, String locDetails) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 120,
                height: 100,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(name,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      // child: ElevatedButton(
                      //   child: Text("View"),
                      //   onPressed: (){
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context){
                      //         return AlertDialog(
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(15.0))
                      //           ),
                      //           scrollable: true,
                      //           content: Column(
                      //             children: [
                      //               Text(name,
                      //                   style: TextStyle(
                      //                       fontSize: 18.0,
                      //                       fontWeight: FontWeight.bold),
                      //                   ),
                      //
                      //               Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Container(
                      //                   width: 300,
                      //                   height: 150,
                      //                   child: ClipRRect(
                      //                     borderRadius:BorderRadius.circular(15.0),
                      //
                      //                     child: Image(
                      //                       height: 300,
                      //                       width: 20,
                      //                       fit: BoxFit.fill,
                      //                       image: NetworkImage(image),
                      //
                      //
                      //                          // get the image link here
                      //
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text(locDetails),
                      //
                      //
                      //
                      //             ],
                      //           ),
                      //         );
                      //       }
                      //
                      //
                      //     );
                      //   },
                      //
                      // ),
                    )
                  ],
                )),
          ),
          SizedBox(height:5.0),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                ],
              )),
          SizedBox(height:5.0),

        ],
      );
    }

    //Fitted Box

    Widget _boxes(String image, double lat, double long, String title, String locDetails){
      return GestureDetector(
        onTap: (){
          gotoLocation(lat,long);
        },
        child: Container(
          child: new FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(image), // get the image link here
                      ),
                    ),

                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          children:[ myDetailsContainer1(title, image, locDetails),

                            ElevatedButton(
                              child: Text("View"),
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                                        ),
                                        scrollable: true,
                                        content: Column(
                                          children: [
                                            Text(title,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 300,
                                                height: 150,
                                                child: ClipRRect(
                                                  borderRadius:BorderRadius.circular(15.0),

                                                  child: Image(
                                                    height: 300,
                                                    width: 20,
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(image),


                                                    // get the image link here

                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(locDetails),



                                          ],
                                        ),
                                      );
                                    }


                                );
                              },

                            ),]), //title variable
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

    }


    //Build Container

    Widget _buildContainer(){

      return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 125.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width:10.0),
                for (int i=0; i<data['location'].length;i++) StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('locations').where('loc_Name', isEqualTo: data['location'][i]).snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.data == null) return CircularProgressIndicator();
                    DocumentSnapshot locData = snapshot.data.docs[0];
                    return Padding(
                        padding: const EdgeInsets.all(8.0) ,
                        child:   _boxes(locData['loc_Img'],locData['loc_Coords'].latitude,locData['loc_Coords'].longitude,locData['loc_Name'], locData['loc_Description']) //add the image lat long and title
                    );
                  },
                ),



              ],
            ),
          ),
        );

    }

    // Zoom Functions

    Future<void> _plus(double zoomVal) async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(7.2906,80.6337),zoom: zoomVal)));
    }


    Future<void> _minus(double zoomVal) async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(7.2906,80.6337),zoom: zoomVal)));
    }

    Widget _zoomPlusFunction(){
      return Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.zoom_in,
            color: Colors.blueAccent,
            size: 30,),
          onPressed: (){
            zoomVal++;
            _plus(zoomVal);
          },

        ),
      );
    }


    Widget _zoomMinusFunction(){
      return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.zoom_out,
          color: Colors.blueAccent,
          size: 30,),
          onPressed: (){
            zoomVal--;
            _minus(zoomVal);
          },

        ),
      );
    }
    Widget _aboutPackage(){
      return Align(
        alignment: Alignment.bottomLeft,

        child: Container(
          height: 245,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:1.0, horizontal: 4.0 ),
            child: Card(
              elevation: 0,
              shadowColor: Colors.white,
              child:ListTile(

                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text('About'),
                ),
                subtitle: Text(data['about']),

              ),
            ),
          ),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _googleMap(context),
          _buildContainer(),
          _zoomPlusFunction(),
          _zoomMinusFunction(),
          _aboutPackage(),
        ],
      ),
    );
  }
}
