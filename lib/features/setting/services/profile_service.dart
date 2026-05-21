import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get uid => auth.currentUser!.uid;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return firestore.collection('users').doc(uid).get();
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    await firestore.collection('users').doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
  }

  Future<void> deleteUserAccount() async {
    final user = auth.currentUser;
    if (user == null) return;

    await firestore.collection('users').doc(user.uid).delete();
    await user.delete();
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}