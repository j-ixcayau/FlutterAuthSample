import 'package:auth/model/user/User.dart';
import 'package:auth/services/User/UserService.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserService _service = UserService();

  User _user;

  /* Getters & Setters */

  User get getUser => _user;
  set setUser(User user) => _user = user;

  /* Services */
  Future<User> requestUser(String id) async {
    final userDoc = await _service.getUser(id);

    if (!userDoc.exists) return null;
    return User.fromMap(userDoc.data(), userDoc.id);
  }

  Future<void> createUser(User user) async {
    return _service.createUser(user);
  }

  Future<void> updateUser(User user) async {
    return _service.updateUser(user);
  }
}
