import 'package:auth/model/user/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore _firestore;
  String _userDb;
  CollectionReference _collectionReference;

  UserService() {
    _firestore = FirebaseFirestore.instance;
    _userDb = "users";
    _collectionReference = _firestore.collection(_userDb);
  }

  Future<DocumentSnapshot> getUser(String id) async {
    return await _collectionReference.doc(id).get();
  }

  Future<void> createUser(User user) async {
    return await _collectionReference.doc(user.getId).set(user.toMap());
  }

  Future<void> updateUser(User user) async {
    return await _collectionReference.doc(user.getId).update(user.toMap());
  }
}
