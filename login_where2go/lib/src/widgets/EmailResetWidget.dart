import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_where2go/src/services/auth_service.dart';

class EmailResetWidget extends StatefulWidget {

  final User user;

  const EmailResetWidget({Key key, this.user}) : super(key: key);
  @override
  _EmailResetWidgetState createState() => _EmailResetWidgetState();
}

class _EmailResetWidgetState extends State<EmailResetWidget> {

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  getUserEmail() async {
    setState(() {
      _email.text = widget.user.email;
    });
  }

  Future updateUserEmail(String email, String pswd) async {

    final auth = AuthService();

    User user = await auth.getCurrentUser();

    try{
      UserCredential credential = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email, password: pswd),
      );

      await credential.user.updateEmail(email).then((value) async {
        await user.reload();
      });
      final currentUser = await auth.getCurrentUser();


      int count = 0;
      Navigator.of(context).popUntil((route) {return count++ == 2;});

    }catch (e) {
      setState(() {
        _email.clear();
        _password.clear();
      });
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Re-Authentication Failed',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Invalid Password, please try again',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: Theme.of(context).textTheme.bodyText2,),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserEmail();
  }

  bool pswdVisible = true;

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

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,),
                    child: TextFormField(
                      controller: _password,
                      autofocus: false,
                      obscureText: pswdVisible,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'empty field..!';
                        }
                        return null;
                      },
                      style: commonTextStyle,
                      decoration: new InputDecoration(
                        errorBorder: commonBorder,
                        enabledBorder: commonBorder,
                        focusedBorder: commonBorder,
                        focusedErrorBorder: commonBorder,
                        border: commonBorder,
                        labelText: 'Re-Enter Password',
                        labelStyle: commonTextStyle,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pswdVisible = !pswdVisible;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,),
                    child: TextFormField(
                      controller: _email,
                      autofocus: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'empty field..!';
                        }
                        return null;
                      },
                      style: commonTextStyle,
                      decoration: new InputDecoration(
                        errorBorder: commonBorder,
                        enabledBorder: commonBorder,
                        focusedBorder: commonBorder,
                        focusedErrorBorder: commonBorder,
                        border: commonBorder,
                        labelText: 'New Email Address',
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'CONFIRM',
                          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            updateUserEmail(_email.text, _password.text);
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
