import 'package:cmr3/screens/auth.dart';
import 'package:cmr3/screens/club_activities.dart';
import 'package:cmr3/screens/notice_board.dart';
import 'package:cmr3/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  static String id = 'main_page';
  final String uid;

  MainPage({this.uid});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  User loggedinuser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "C M R I T",
            style: TextStyle(color: Colors.white70),
          )),
          backgroundColor: Colors.grey,
          actions: <Widget>[
            RaisedButton(
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 10),
              ),
              color: Colors.white70,
              elevation: 50,
              padding: EdgeInsets.all(20),
              onPressed: () {
                googlesignout();
                if (signInWithUser() != null) {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/cmritlogo.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        NetworkImage(loggedinuser.photoURL))),
                          ),
                          Text('Welcome!'),
                          SizedBox(height: 10),
                          Text(loggedinuser.displayName)
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.black12),
                ),
              ),
              ListTile(
                title: Text("Notice Board"),
                onTap: () {
                  Navigator.pushNamed(context, NoticeBoard.id);
                },
              ),
              ListTile(
                title: Text("Attendance"),
              ),
              ListTile(
                title: Text("Performance Predictor"),
                onTap: () {
                  Navigator.pushNamed(context, NoticeBoard.id);
                },
              ),
              ListTile(
                title: Text("Club Activities"),
                onTap: () {
                  Navigator.pushNamed(context, ClubActivities.id);
                },
              ),
              ListTile(
                title: Text("Lost & Found"),
                onTap: () {
                  Navigator.pushNamed(context, NoticeBoard.id);
                },
              ),
              ListTile(
                title: Text("Help"),
                onTap: () {
                  Navigator.pushNamed(context, NoticeBoard.id);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/cmritlogo.png'),
            ),
            SizedBox(height: 100),
            Center(
                child: Center(
              child: Text("College Information Area",
                  style: TextStyle(fontSize: 20)),
            ))
          ],
        ));
  }
}
