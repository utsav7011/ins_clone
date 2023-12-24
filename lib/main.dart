import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ins_clone/providers/user_provider.dart';
import 'package:ins_clone/responses/mobile_screen_layout.dart';
import 'package:ins_clone/responses/web_screen_layout.dart';
import 'package:ins_clone/screens/login_screen.dart';
import 'package:ins_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import 'responses/responses_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAKqtjMsUtcVDDF_MR8BkQNx4HeLyNfilU",
        authDomain: "insclone-35d5e.firebaseapp.com",
        projectId: "insclone-35d5e",
        storageBucket: "insclone-35d5e.appspot.com",
        messagingSenderId: "942352944696",
        appId: "1:942352944696:web:c617099379c6c21f53a0cd",
        measurementId: "G-8KX77JZ5J3",
      ),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram_Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: ,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  WebScreenLayout(),
                  MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}