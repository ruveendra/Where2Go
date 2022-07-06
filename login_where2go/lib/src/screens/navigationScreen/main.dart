// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_app_01/about_page.dart';
// import 'package:flutter_app_01/map_page.dart';
// import 'package:flutter_app_01/profile.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: MapSample(),
//     );
//   }
// }

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   child: Container(
//                     width: double.infinity,
//                     child: TextButton(
//                       onPressed: () async {
//                         Navigator.push(this.context, MaterialPageRoute(builder: (context) => MapPage()));
//                       },
//                       child: Text('LOCATION', style: Theme.of(context).textTheme.headline6,),
//                       style: TextButton.styleFrom(
//                         backgroundColor: Theme.of(context).accentColor,
//                         shape: StadiumBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   child: Container(
//                     width: double.infinity,
//                     child: TextButton(
//                       onPressed: () async {
//                         Navigator.push(this.context, MaterialPageRoute(builder: (context) => ProfilePage())); 
//                       },
//                       child: Text('USER PROFILE', style: Theme.of(context).textTheme.headline6,),
//                       style: TextButton.styleFrom(
//                         backgroundColor: Theme.of(context).accentColor,
//                         shape: StadiumBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   child: Container(
//                     width: double.infinity,
//                     child: TextButton(
//                       onPressed: () async {
//                         Navigator.push(this.context, MaterialPageRoute(builder: (context) => AboutPage()));
//                       },
//                       child: Text('ABOUT', style: Theme.of(context).textTheme.headline6,),
//                       style: TextButton.styleFrom(
//                         backgroundColor: Theme.of(context).accentColor,
//                         shape: StadiumBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
