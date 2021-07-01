import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoard extends StatefulWidget {
  static String id = 'notice_board';
  final String uid;

  NoticeBoard({this.uid});

  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedinuser;
  String announcement;
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

  void announcementStream() async {
    await for (var snapshot
        in _firestore.collection('announcements').snapshots()) {
      for (var announcement in snapshot.docs) {
        print(announcement.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice Board"),
        backgroundColor: Colors.black12,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Bineet Kumar'),
                  subtitle: Text(
                    'ISE Department',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'IAT-3 commences from 20-01-2021,portions include mod-4 and mod-5',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(
                    'Department',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Announcements/Information Area',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(
                    'Department',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Announcements/Information Area',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(
                    'Department',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Announcements/Information Area',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ),
          Container(
              child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    announcement = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  _firestore.collection('announcements').add({
                    'name': loggedinuser.displayName,
                    'message': announcement
                  });
                  announcementStream();
                },
                child: Text("Announce"),
              )
            ],
          ))
        ],
      ),
    );
  }
}
