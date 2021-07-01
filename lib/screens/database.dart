import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;

  DataBaseService({this.uid});

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String photourl, String email) async {
    return await usercollection
        .doc(uid)
        .set({'name': name, 'photoUrl': photourl, 'email': email});
  }
}
