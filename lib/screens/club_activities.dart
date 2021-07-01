import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ClubActivities extends StatefulWidget {
  static String id = 'club_activities';
  final String uid;

  ClubActivities({this.uid});

  @override
  _ClubActivitiesState createState() => _ClubActivitiesState();
}

class _ClubActivitiesState extends State<ClubActivities> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedinuser;
  String announcement;
  String imageUrl;
  int count = 0;

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
      appBar: AppBar(title: Text('Upload Image')),
      body: Column(
        children: <Widget>[
          Container(
            height: 500,
            width: 500,
            child: (imageUrl != null)
                ? Image.network(imageUrl)
                : Placeholder(
                    fallbackHeight: 200.0, fallbackWidth: double.infinity),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Upload Image'),
            color: Colors.lightBlue,
            onPressed: () => uploadImage(),
          )
        ],
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    String currentUsername = loggedinuser.displayName;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('Club_Images/$currentUsername/$count')
            .putFile(file)
            .onComplete;
        count = count + 1;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
