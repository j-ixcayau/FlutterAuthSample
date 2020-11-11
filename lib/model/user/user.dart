import 'package:auth/model/base/BaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User with BaseModel {
  String _id;
  String _name;
  String _email;
  String _profilePicture;
  String _phone;
  String _address;
  String _description;
  GeoPoint _homeLocation;

  User({
    String id = "",
    String name = "",
    String email = "",
    String profilePicture = "",
    String phone = "",
    String address = "",
    String description = "",
    GeoPoint homeLocation,
  }) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._profilePicture = profilePicture;
    this._phone = phone;
    this._address = address;
    this._description = description;
    this._homeLocation = homeLocation;
  }

  String get getId => validString(_id);
  String get getName => validString(_name);
  String get getEmail => validString(_email);
  String get getProfilePicture => validString(_profilePicture);
  String get getPhone => validString(_phone);
  String get getAddress => validString(_address);
  String get getDescription => validString(_description);
  GeoPoint get getHomeLocation => _homeLocation;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setEmail(String email) => _email = email;
  set setProfilePicture(String url) => _profilePicture = url;
  set setPhone(String phone) => _phone = phone;
  set setAddress(String address) => _address = address;
  set setDescription(String description) => _description = description;
  set setHomeLocation(GeoPoint location) => _homeLocation = location;

  factory User.fromMap(Map<String, dynamic> json, String id) {
    return User(
      id: id,
      name: json["name"],
      email: json["email"],
      profilePicture: json['profilePicture'],
      phone: json['phone'],
      address: json['address'],
      description: json['description'],
      homeLocation: json['homeLocation'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": _id,
        "name": getName,
        "email": getEmail,
        "profilePicture": getProfilePicture,
        "phone": getPhone,
        "address": getAddress,
        "description": getDescription,
        "homeLocation": getHomeLocation,
      };
}
