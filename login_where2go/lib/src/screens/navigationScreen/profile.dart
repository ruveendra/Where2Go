import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/screens/profileScreens/email_reset_page.dart';
import 'package:login_where2go/src/screens/profileScreens/name_reset_page.dart';

class ProfilePage extends StatefulWidget {

  final User user;

  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
    );

    TextStyle commonTextStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4.0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2.0,
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 10.0))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ))),
                  ),
                  Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),

            Divider(
              thickness: 1,
              color: Theme.of(context).accentColor.withOpacity(0.5),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.account_circle_outlined)),
                  Text(
                    "Personal Information",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NameResetPage(user: widget.user,)));
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: commonBorder,
                      disabledBorder: commonBorder,
                      enabledBorder: commonBorder,
                      errorBorder: commonBorder,
                      focusedErrorBorder: commonBorder,
                      focusedBorder: commonBorder,
                      labelText: 'Name : ${widget.user.displayName}',
                      labelStyle: commonTextStyle,
                    ),
                    maxLines: 1,
                    autofocus: false,
                    enabled: false,
                    style: commonTextStyle,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserEmailReset(user: widget.user,)));
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: commonBorder,
                      disabledBorder: commonBorder,
                      enabledBorder: commonBorder,
                      errorBorder: commonBorder,
                      focusedErrorBorder: commonBorder,
                      focusedBorder: commonBorder,
                      labelText: 'Email : ${widget.user.email}',
                      labelStyle: commonTextStyle,
                    ),
                    maxLines: 1,
                    autofocus: false,
                    enabled: false,
                    style: commonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}