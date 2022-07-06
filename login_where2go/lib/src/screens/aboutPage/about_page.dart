import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
              child: ListView(
                children: [
                  Container(
                    child: Image.asset('assets/images/img4.jpg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Sri Lanka is an island which is full of eye-catching places, but still many of the places are not known to the public. Therefore, We “where2go” , provide the facility to you to find and explore these beautiful destinations .',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Transform.translate(
          offset: Offset(0,20),
          child: Image.asset('assets/images/img5.webp'),
        ),
      ),
    );
  }
}
