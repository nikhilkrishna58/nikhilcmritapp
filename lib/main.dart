import 'package:cmr3/screens/club_activities.dart';
import 'package:cmr3/screens/notice_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_page.dart';
import 'screens/notice_board.dart';
import 'screens/club_activities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MainPage.id: (context) => MainPage(),
        NoticeBoard.id: (context) => NoticeBoard(),
        ClubActivities.id: (context) => ClubActivities(),
      },
    );
  }
}
