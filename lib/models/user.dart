import 'package:cloud_firestore/cloud_firestore.dart';

class User_model {
  final String bio;
  final String email;
  final List followers;
  final List follwoing;
  final String photoUrl;
  final String uid;
  final String username;

  const User_model({
    required this.bio,
    required this.email,
    required this.followers,
    required this.follwoing,
    required this.photoUrl,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photourl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": follwoing,
      };

  static User_model fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User_model(
        bio: snapshot['bio'],
        email: snapshot['email'],
        followers: snapshot['followers'],
        follwoing: snapshot['following'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
