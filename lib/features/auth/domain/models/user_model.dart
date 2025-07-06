import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final String? dob;
  final String? country;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.dob,
    this.country,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      phone: map['phone'],
      dob: map['dob'],
      country: map['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'dob': dob,
      'country': country,
    };
  }
}
