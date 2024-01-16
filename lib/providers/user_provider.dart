import 'package:flutter/material.dart';
import 'package:ins_clone/models/user.dart';
import 'package:ins_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();
  User_model? _user;

  User_model get getUser => _user!;

  Future<void> refreshUser() async {
    User_model user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
