// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exam_event_app/data/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<UserModel?> registerUser(
//       String email, String password, String username) async {
//     try {
//       final UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
        
//       );
//       final User? firebaseUser = userCredential.user;
//       if (firebaseUser != null) {
//         await _firestore.collection('users').doc(firebaseUser.uid).set({
//           'email': firebaseUser.email,
//           'username': username,
//         });

//         return UserModel(
//           id: firebaseUser.uid,
//           email: firebaseUser.email ?? '',
//           displayName: firebaseUser.displayName ?? '',
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }
//   Future<UserModel?> signUpUser(
//     String email,
//     String password,
//   ) async {
//     try {
//       final UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
        
//       );
//       final User? firebaseUser = userCredential.user;
//       if (firebaseUser != null) {
//         return UserModel(
//           id: firebaseUser.uid,
//           email: firebaseUser.email ?? '',
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   Future<void> signOutUser() async {
//     final User? firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       await FirebaseAuth.instance.signOut();
//     }
//   }
// }


// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';

// class UserAuthService {
//   final _userAuthentication = FirebaseAuth.instance;
//   final _userfirebase = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;

//   Future<void> registerUser(
//     BuildContext context,
//     String email,
//     String password,
//     String username,
//   ) async {
//     UserCredential userCredential =
//         await _userAuthentication.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     User? user = userCredential.user;
//     // String? userToken = await FirebasePushNotificationService.getToken();

//     if (user != null) {
//       await _userfirebase.collection("users").doc(user.uid).set(
//         {
//           // "token": userToken,
//           "token": "qqq",
//           "email": user.email,
//           "userName": username,
//           "photoUrl": "",
//         },
//       );
//     }
//     if (context.mounted) {
//       Navigator.pop(context);
//     }
//   }

//   Future<void> logInUser(String email, String password) async {
//     await _userAuthentication.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<void> resetPasswordUser(String email) async {
//     await _userAuthentication.sendPasswordResetEmail(
//       email: email,
//     );
//   }

//   Future<void> signOut() async {
//     await _userAuthentication.signOut();
//   }

//   Future<DocumentSnapshot> getUserInfo(String userUid) async {
//     return await _userfirebase.collection('users').doc(userUid).get();
//   }

//   Stream<QuerySnapshot> getAllUsers() async* {
//     yield* _userfirebase.collection('users').snapshots();
//   }

//   Future<void> updateProfile(String id, String name, {String? photoUrl}) async {
//     await _userfirebase.collection('users').doc(id).update(
//       {
//         "userName": name,
//         if (photoUrl != null) "photoUrl": photoUrl,
//       },
//     );
//   }

//   Future<String?> uploadProfileImage(File imageFile, String userId) async {
//     try {
//       Reference storageReference =
//           _storage.ref().child('profile_images/$userId.jpg');
//       UploadTask uploadTask = storageReference.putFile(imageFile);
//       TaskSnapshot snapshot = await uploadTask;
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading profile image: $e');
//       return null;
//     }
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:exam_event_app/data/models/user_model.dart';

class UserAuthService {
  final _userAuthentication = FirebaseAuth.instance;
  final _userfirebase = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<UserModel?> registerUser(
    // BuildContext context,
    String email,
    String password,
    String username,
  ) async {
    UserCredential userCredential =
        await _userAuthentication.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    // String? userToken = await FirebasePushNotificationService.getToken();

    if (user != null) {
      await _userfirebase.collection("users").doc(user.uid).set(
        {
          // "token": userToken,
          "token": "qqq",
          "email": user.email,
          "userName": username,
          "photoUrl": "",
        },
      );
      DocumentSnapshot userDoc =
          await _userfirebase.collection("users").doc(user.uid).get();
      return UserModel.fromJson(userDoc);
    }
    // if (context.mounted) {
    //   Navigator.pop(context);
    // }
    return null;
  }

  Future<UserModel?> logInUser(String email, String password) async {
    UserCredential userCredential =
        await _userAuthentication.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _userfirebase.collection("users").doc(user.uid).get();
      return UserModel.fromJson(userDoc);
    }
    return null;
  }

  Future<void> resetPasswordUser(String email) async {
    await _userAuthentication.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> signOut() async {
    await _userAuthentication.signOut();
  }

  Future<DocumentSnapshot> getUserInfo(String userUid) async {
    return await _userfirebase.collection('users').doc(userUid).get();
  }

  Stream<QuerySnapshot> getAllUsers() async* {
    yield* _userfirebase.collection('users').snapshots();
  }

  Future<void> updateProfile(String id, String name, {String? photoUrl}) async {
    await _userfirebase.collection('users').doc(id).update(
      {
        "userName": name,
        if (photoUrl != null) "photoUrl": photoUrl,
      },
    );
  }

  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      Reference storageReference =
          _storage.ref().child('profile_images/$userId.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }
}

