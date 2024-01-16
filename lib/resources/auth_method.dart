import 'dart:typed_data';
import 'package:ins_clone/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ins_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User_model> getUserDetails() async {
    // User currentUser = _auth.currentUser;

    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return User_model.fromSnap(snap);
  }

  // signUpUser
  Future<String> signupUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'Some error Occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        // register user:
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        // String photoUrl = '';
        // add user to database:

        User_model user = User_model(
            bio: bio,
            email: email,
            followers: [],
            follwoing: [],
            photoUrl: photoUrl,
            uid: cred.user!.uid,
            username: username);

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'follwoing': [],
        // });

        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      }
      if (err.code == 'weak-password') {
        res = 'the password is weak!!';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user:
  // ignore: non_constant_identifier_names
  Future<String> LoginUser(
      {required String email, required String password}) async {
    String res = "Some error Occured !!";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the feilds.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
