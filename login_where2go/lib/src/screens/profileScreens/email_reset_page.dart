import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/widgets/EmailResetWidget.dart';

class UserEmailReset extends StatefulWidget {

  final User user;

  const UserEmailReset({Key key, this.user}) : super(key: key);

  @override
  _UserEmailResetState createState() => _UserEmailResetState();
}

class _UserEmailResetState extends State<UserEmailReset> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
          title: Text(
            "CHANGE EMAIL",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        body: EmailResetWidget(user: widget.user,),
      ),
    );
  }
}
