import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ins_clone/screens/feed_screen.dart';
import 'package:ins_clone/screens/search_screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/profile_screen.dart';

const webScreen = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notif'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
