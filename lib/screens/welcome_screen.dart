import 'package:flutter/material.dart';
import 'package:cmr3/screens/auth.dart';
import 'package:cmr3/screens/main_page.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('images/cmritlogo.png'),
        ),
        title: Text(
          "CMRIT",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Image(
              image: AssetImage('images/cmritlogo.png'),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 220, maxHeight: 30),
            child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/glogo2.png'),
                    ),
                    SizedBox(),
                    Text("Login With Google")
                  ],
                ),
                onPressed: () {
                  signInWithUser().whenComplete(() => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => MainPage(uid: '1123'))));
                }),
          )
        ],
      ),
    );
  }
}
