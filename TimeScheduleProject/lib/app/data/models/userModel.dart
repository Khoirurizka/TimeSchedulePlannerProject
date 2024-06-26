// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String email;
  late String userName;
  late String userRole;
  late String userId;

  UserModel.name({
    required this.email,
    required this.userName,
    required this.userRole,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'username': userName,
        'uid': userId,
        'userrole': userRole,
        'email': email,
      };

  static UserModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel.name(
        email: snapshot['email'],
        userId: snapshot['uid'],
        userName: snapshot['username'],
        userRole: snapshot['userrole']);
  }
}
