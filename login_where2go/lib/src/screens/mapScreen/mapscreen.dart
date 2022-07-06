import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


import 'package:login_where2go/src/screens/mapScreen/location_service.dart';
import 'package:url_launcher/url_launcher.dart';



class GoogleMapsScreen extends StatefulWidget {
   final User userinMap;
  GoogleMapsScreen({this.userinMap});
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}


class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final auth = FirebaseAuth.instance;
  GoogleMapController mapController;
  Position currentPosition;
  List<Marker> allMarkers =[];
  var selectedLocationId;

  //get current position
  void locatePosition() async{
  bool serviceEnabled;
  LocationPermission permission;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 
    if (permission == LocationPermission.denied) {
      return Future.error(
          'Location permissions are denied');
    }
  }
  // When we reach here, permissions are granted and we can continue accessing the position of the device.
  // initialCameraPosition: CameraPosition(target: LatLng(6.927079, 79.861244),zoom:14),
      Position position =  await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
      //getting user location interms of longitudes and latitudes
      LatLng latLngPosition = LatLng(6.927079,79.861244);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLngPosition,zoom:12.0),
    ));
   
  }
  
//populae the map
  populateMarkerFirestores() {
   FirebaseFirestore.instance.collection('locations').get().then((result){
      if(result.docs.isNotEmpty){
        for(int i=0 ;i<result.docs.length;i++){
          // print(result.docs[i]['loc_Name']);
            setState(() {
              allMarkers.add(Marker(
                  markerId: MarkerId(result.docs[i].id),
                  position: LatLng(result.docs[i]["loc_Coords"].latitude,result.docs[i]["loc_Coords"].longitude),
                  infoWindow: InfoWindow(
                    title:result.docs[i]['loc_Name'],
                  ),
                  onTap: (){
                    setState(() {
                      selectedLocationId = result.docs[i];
                    });
                    _tripInfoModalBottomSheet(context,result.docs[i]);
                  }
              ));
            });
        }
      }
    });
   // print(allMarkers.length);
  }

//showing modal Sheet
void _tripInfoModalBottomSheet(context,QueryDocumentSnapshot qds){

    var locationName =qds['loc_Name'];
    var locationDescription = qds['loc_Description'];
    var locationLattitude  =qds["loc_Coords"].latitude;
    var locationLongitude = qds["loc_Coords"].longitude;

  showModalBottomSheet(context:context,builder :(BuildContext bc){
    return SafeArea(
          child: Container(
        height:MediaQuery.of(context).size.height* 0.9,
         child:Padding(
           padding:EdgeInsets.all(10.0),
           child:ListView(
             children: [
               Row(
                 children: [
             //location name
                     Text( locationName,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
              //extend to end
                   Spacer(),
              //close button     
                   IconButton(icon: Icon(Icons.cancel),
                   color:Colors.blueAccent,
                    onPressed: (){
                      Navigator.of(context).pop();
                   })
                 ],
               ),
           //locationn details
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(locationDescription),
               ),
          //locatioon image
               Container(
                 height:300,
                 child: Image.network(
                   qds['loc_Img'],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
              ),
            );
          },
        ),
               ),

       Row(
   mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    //addto list
          RaisedButton.icon(
                  onPressed: () async {
                      bool result = await LocationService().isLocationAlreadyInList(selectedLocationId,widget.userinMap.uid);
                       if(result == true ){
                         print('------location already listed-----');
                        displayAlreadyListedMessage();
                       }
                      else{
                      LocationService().storeSelectedUserLocations(selectedLocationId,widget.userinMap.uid);
                     displaySucessfullMessage();
                      }
                     // to do: say record added to list
                   // Navigator.of(context).push(MaterialPageRoute(builder:(context) => Where2GoList(data: selectedLocationId,currentListuser:widget.userinMap)));
                     },
                  shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Add to List',
                         style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.add_location_rounded, color:Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.lightBlue,
                  ),
               //google maps to navigate
               RaisedButton.icon(
              onPressed: ()  async{ 
                // displaySucessfullMessage();
                // _launchMapsUrl(locationLattitude, locationLongitude);
                 _launchMapsUrl(7.9572, 80.7600);
               },
              shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(' Navigate',
                     style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.camera_alt, color:Colors.white,),
              textColor: Colors.white,
              splashColor: Colors.red,
              color: Colors.lightBlue,),
                ],
),
             ],
           ),)
          //  child:Text(locname),
      ),
    );
  });
}


//getting adata from firebase
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     locatePosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      populateMarkerFirestores();
      // locatePosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    //User userMap =widget.userinMap;
    return Scaffold(
    appBar: AppBar(
      backgroundColor:Colors.blueAccent ,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: " Return to Home",
         onPressed: () {Navigator.pop(context);}
        ),
      title:Text('Explore Sri Lanka'),
      ),
    body:Container(
      child: Stack(
        children: [
          Container(
            // height:MediaQuery.of(context).size.height* 0.8,
            child: GoogleMap(
              // Colombo Co-ordinates
              initialCameraPosition: CameraPosition(target: LatLng(6.927079, 79.861244),zoom:14),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true, 
              myLocationButtonEnabled: true,// Add little blue dot for device location, requires permission from user
              mapType: MapType.normal,
              // check
              markers:Set.from(allMarkers),
            ),
          ),
          // Positioned(
          //   bottom: 50,
          //   right: 10,
          //   child:TextButton(
          //     child: Icon(Icons.pin_drop),style: TextButton.styleFrom(backgroundColor: Colors.green,),
          //     onPressed:(){
          //        print('----- check uid in Map screen ------');
          //        print(userMap.uid);
          //       //var test = FirebaseFirestore.instance.collection('locations').where("name", isEqualTo: "Kandy").snapshots();
          //    },
          // ),
          // )
          ],
      ),
    
    )
    );
  }
                
displaySucessfullMessage(){
   return showDialog(
                      context: context,
                      builder: (_) => NetworkGiffyDialog(
                            image: Image.network(
                              "https://cdn.dribbble.com/users/129972/screenshots/3964116/75_smile.gif",
                              fit: BoxFit.cover,
                            ),
                            entryAnimation: EntryAnimation.TOP_LEFT,
                            title: Text(
                              'Location Sucessfully added',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                            description: Text(
                              'This journey of yours definitely will be full of extraordinary memories and sweet moments.',
                              textAlign: TextAlign.center,
                            ),
                            onlyOkButton: true,
                                onOkButtonPressed: () {Navigator.pop(context);},
                          ));
}
displayAlreadyListedMessage(){
   return showDialog(
                      context: context,
                      builder: (_) =>  
                NetworkGiffyDialog(
                  image: Image.network(
                      "https://i.pinimg.com/originals/db/1c/9d/db1c9da1645be27221feca1aa55b8eee.gif",
                        fit: BoxFit.cover,
                                  ),
                                entryAnimation: EntryAnimation.TOP_LEFT,
                                title: Text(
                                  'Location is already listed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22.0, fontWeight: FontWeight.w600),
                                ),
                                description: Text(
                                  'This journey of yours is already on your Where2golist.We guide you to discover amazing places like this.',
                                  textAlign: TextAlign.center,
                                ),
                                onlyOkButton: true,
                                onOkButtonPressed: () {Navigator.pop(context);},
                              ),
                     );
              }
  




  void _launchMapsUrl(double lat, double lon) async {
    print('-------------------------');
    print(lon);
    final url = 'https://www.google.com/maps/search/?api=AIzaSyCN_lDZgqdM8OiDHF022qHuU4CCZH0xRIA&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  }
