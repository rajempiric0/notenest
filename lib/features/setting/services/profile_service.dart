import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../auth/pages/login_page.dart';

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
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    if (user.email != email) {
      await user.verifyBeforeUpdateEmail(email);
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
  }

  Future<void> deleteUserAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Get.snackbar(
          'Login again',
          'For security, please login again before deleting account.',
        );

        await FirebaseAuth.instance.signOut();
        Get.offAll(() => LoginPage());
      } else {
        Get.snackbar('Error', e.message ?? 'Something went wrong');
      }
    }
  }


  Future<void> logout() async {
    await auth.signOut();
  }
}