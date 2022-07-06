import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/services/auth_service.dart';

class NameResetWidget extends StatefulWidget {

  final User user;

  const NameResetWidget({Key key, this.user}) : super(key: key);

  @override
  _NameResetWidgetState createState() => _NameResetWidgetState();
}

class _NameResetWidgetState extends State<NameResetWidget> {

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();

  getUserName() async {
    setState(() {
      _name.text = widget.user.displayName;
    });
  }

  Future updateUserName(String name) async {
    final auth = AuthService();

    User user = await auth.getCurrentUser();
    await user.updateProfile(
      displayName: name,
    ).then((value) async {
      await user.reload();
    });
    final currentUser = await auth.getCurrentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
    );

    TextStyle commonTextStyle = Theme.of(context).textTheme.subtitle1;

    return Stack(
      children: [
        Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        String namePattern = r'^[A-Za-z ]{3,40}$';
                        RegExp regExpName = new RegExp(namePattern);
                        if (value.isEmpty) {
                          return 'Name is Missing';
                        } else if (!regExpName.hasMatch(value)) {
                          return 'Please enter a appropriate name';
                        }
                        return null;
                      },
                      controller: _name,
                      style: commonTextStyle,
                      decoration: InputDecoration(
                        errorBorder: commonBorder,
                        enabledBorder: commonBorder,
                        focusedBorder: commonBorder,
                        focusedErrorBorder: commonBorder,
                        border: commonBorder,
                        labelText: 'Name *',
                        labelStyle: commonTextStyle,
                      ),
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'CONFIRM',
                          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            updateUserName(_name.text).then((value){
                              int count = 0;
                              Navigator.of(context).popUntil((route) {return count++ == 2;});
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
