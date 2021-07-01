import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cmr3/screens/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User> signInWithUser() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);

  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(user.getIdToken() != null);

  final User currentuser = _auth.currentUser;
  assert(currentuser.uid == user.uid);

  await DataBaseService(uid: user.uid)
      .updateUserData(user.displayName, user.photoURL, user.email);

  return user;
}

googlesignout() async {
  await _googleSignIn.signOut();
}
