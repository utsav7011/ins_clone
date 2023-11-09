import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ins_clone/responses/mobile_screen_layout.dart';
import 'package:ins_clone/responses/web_screen_layout.dart';
import 'package:ins_clone/screens/login_screen.dart';
import 'package:ins_clone/screens/signup_screen.dart';
import 'package:ins_clone/utils/colors.dart';
import 'responses/responses_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAKqtjMsUtcVDDF_MR8BkQNx4HeLyNfilU',
          appId: '1:942352944696:web:c617099379c6c21f53a0cd',
          messagingSenderId: '942352944696',
          projectId: 'insclone-35d5e',
          storageBucket: 'insclone-35d5e.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram_Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   WebScreenLayout(),
      //   MobileScreenLayout(),
      // ),
      home: SignupScreen(),
    );
  }
}
