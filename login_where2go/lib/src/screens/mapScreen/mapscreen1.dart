import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:login_where2go/src/screens/where2goList/where2goList.dart';



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

  // get current position
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
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
      Position position =  await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
      //getting user location interms of longitudes and latitudes
      LatLng latLngPosition = LatLng(position.latitude,position.longitude);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLngPosition,zoom:16.0),
    ));
   
  }
  

//populae the map
  populateMarkerFirestores() {
   FirebaseFirestore.instance.collection('locations').get().then((result){
      if(result.docs.isNotEmpty){
        for(int i=0 ;i<result.docs.length;i++){
          print(result.docs[i]['loc_Name']);
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
  showModalBottomSheet(context:context,builder :(BuildContext bc){
    return SafeArea(
         child:Container(
        height:MediaQuery.of(context).size.height* 0.3,
           padding:EdgeInsets.all(10.0),
           decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(130),
                topRight: const Radius.circular(130),
                )
             ),
           child:ListView(
             children: [
               Row(
                 children: [
                   Text(locationName),
                   Spacer(),//extend to end
                   IconButton(icon: Icon(Icons.cancel),
                   color:Colors.blueAccent,
                    onPressed: (){
                      Navigator.of(context).pop();
                   })
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(locationDescription),
               ),
              //  adding Image
               Container(
                height:  300.0,
                child:Image.network(qds['loc_Img']),
               ),
               //where to go list Button
Row(
   mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  
    //addto list
          RaisedButton.icon(
                  onPressed: (){
                      storeSelectedUserLocations(selectedLocationId,widget.userinMap.uid);
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => Where2GoList(data: selectedLocationId,currentListuser:widget.userinMap)));
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
              onPressed: (){ print('Navigate Clicked.'); },
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
           ),),
          //  child:Text(locname),
      
      );
    
  });
}
// get newGoogleMapController => null;
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
       locatePosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    User userMap =widget.userinMap;
    return Scaffold(
    appBar: AppBar(
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
              initialCameraPosition: CameraPosition(target: LatLng(6.927079, 79.861244),zoom:9),
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
          // ),)
          ],
      ),
    
    )
    );
  }

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
