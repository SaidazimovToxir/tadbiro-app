// import 'package:firebase_auth/firebase_auth.dart';

// class UserModel {
//   final String? id;
//   final String? email;
//   final String? username;
//   UserModel({
//     this.id,
//     this.email,
//     this.username,
//   });

//   factory UserModel.fromFirebaseUser(User? user) {
//     return UserModel(
//       id: user?.uid,
//       email: user?.email,
//       username: user?.username,
//       // photoURL: user?.photoURL,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String id;
//   String email;
//   String userName;
//   String photoUrl;
//   String token;
//   UserModel({
//     required this.id,
//     required this.token,
//     required this.email,
//     required this.userName,
//     required this.photoUrl,
//   });

//   factory UserModel.fromJson(QueryDocumentSnapshot snap) {
//     return UserModel(
//       id: snap.id,
//       token: snap['token'],
//       email: snap["email"],
//       userName: snap['userName'],
//       photoUrl: snap['photoUrl'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String userName;
  String photoUrl;
  String token;

  UserModel({
    required this.id,
    required this.token,
    required this.email,
    required this.userName,
    required this.photoUrl,
  });

  factory UserModel.fromJson(DocumentSnapshot snap) {
    return UserModel(
      id: snap.id,
      token: snap['token'],
      email: snap["email"],
      userName: snap['userName'],
      photoUrl: snap['photoUrl'],
    );
  }
}
