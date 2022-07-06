import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_where2go/src/screens/aboutPage/about_page.dart';
// import 'package:login_where2go/src/screens/login.dart';
 import 'package:login_where2go/src/screens/login.dart';
import 'package:login_where2go/src/screens/mapScreen/mapscreen.dart';
import 'package:login_where2go/src/screens/where2goList/where2goList.dart';
 import 'package:login_where2go/src/services/auth_service.dart';
import 'package:login_where2go/src/widgets/HomeSliderWidget.dart';

import 'choose_package.dart';
import 'navigationScreen/profile.dart';


class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Where2Go')
      ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: Drawer(

            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  onDetailsPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: user,)));
                  },
                  currentAccountPicture: CircleAvatar(
                    //backgroundImage: AssetImage("assets/images/jeep.jpg"),
                    backgroundImage: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2012/05/20172622/ce-travel.jpg'),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.blue[600],
                      Colors.blue[300],
                    ]),
                  ),
                  accountEmail: Text("${user.email}"),
                  accountName: Text("${user.displayName}"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  trailing: Icon(Icons.arrow_forward),
                  title: Text("Home"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Where2GoList(currentListuser:user) ));
                  },
                  leading: Icon(Icons.list),
                  trailing: Icon(Icons.arrow_forward),
                  title: Text("To Go List"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=> GoogleMapsScreen(userinMap:user)));
                  },
                  leading: Icon(Icons.place),
                  trailing: Icon(Icons.arrow_forward),
                  title: Text("Explore Sri Lanka"),
                ),
                ListTile(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritesPage()));
                  },
                  leading: Icon(Icons.favorite),
                  trailing: Icon(Icons.arrow_forward),
                  title: Text("Favorite"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                  leading: Icon(Icons.analytics),
                  trailing: Icon(Icons.arrow_forward),
                  title: Text("About"),
                ),
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
        ),
       body: Stack(
         children: <Widget>[
           Center(
             child: ListView(
               children: [

                 HomeSliderWidget(),

                 Padding(
                   padding: EdgeInsets.only(top: 10),
                   child: TextButton(
                     onPressed: () async {
                       Navigator.of(context).push(MaterialPageRoute(builder:(context)=> GoogleMapsScreen(userinMap:user)));
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
                               "Explore Sri Lanka",
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
                       Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Where2GoList(currentListuser:user) ));
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
                               "To Go List",
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
                   padding: EdgeInsets.only(top: 10, bottom: 15),
                   child: TextButton(
                     onPressed: () async {
                       //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedUser()));
                       Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ChoosePackage(currentListuser:user) ));
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
                                 image: AssetImage('assets/images/image3.jpeg'),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),

                           Padding(
                             padding: EdgeInsets.only(left: 10),
                             child: Text(
                               "Our Pre Made Plans For You",
                               textAlign: TextAlign.center,
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
                   padding: EdgeInsets.symmetric(horizontal: 15),
                   child: Divider(
                     color: Colors.black,
                   ),
                 ),

                 Padding(
                   padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Icon(
                         Icons.star_border_rounded,
                         size: 30,
                       ),
                       Text(
                         "Popular Destinations",
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 18,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ],
                   ),
                 ),

                 Container(
                   height: 100,
                   padding: EdgeInsets.symmetric(horizontal: 20,),
                   child: new ListView(
                     children:[
                       Container(
                         height: 80,
                         width: 100,
                         margin: EdgeInsets.all(5.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           image: DecorationImage(
                             //image: AssetImage('assets/yoga/yoga_1.jpg'),
                             image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/where2gologin.appspot.com/o/galleFaceGreen.jpg?alt=media&token=36801557-5f2d-42a9-91fa-77a36345c5dd'),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       Container(
                         height: 80,
                         width: 100,
                         margin: EdgeInsets.all(5.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           image: DecorationImage(
                             //image: AssetImage('assets/yoga/yoga_1.jpg'),
                             image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/where2gologin.appspot.com/o/sigiriya.jpg?alt=media&token=798566b9-5661-40a1-a13b-1c1994978f35'),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       Container(
                         height: 80,
                         width: 100,
                         margin: EdgeInsets.all(5.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           image: DecorationImage(
                             //image: AssetImage('assets/yoga/yoga_1.jpg'),
                             image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/where2gologin.appspot.com/o/parakramaSamudra.jpg?alt=media&token=e4cecb39-c4a1-453c-8b2f-46243a6de938'),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       Container(
                         height: 80,
                         width: 100,
                         margin: EdgeInsets.all(5.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           image: DecorationImage(
                             //image: AssetImage('assets/yoga/yoga_1.jpg'),
                             image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/where2gologin.appspot.com/o/gangaramaTemple.jpg?alt=media&token=8acbc2b0-ac1e-4d21-929c-5db0f3247827'),
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ],
                     scrollDirection: Axis.horizontal,
                   ),
                 ),
               ],
             ),
           )
         ],
       ),
    );
  }
//not working error
//  Future <String> getCurrentUID() async {
//      final User user= FirebaseAuth.instance.currentUser;
//      if(user==null){print('user is null');}
//     return user.uid;
//   }
}