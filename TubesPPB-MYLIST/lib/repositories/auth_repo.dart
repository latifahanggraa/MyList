import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Lakukan sesuatu dengan userCredential.user jika perlu
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong during login!';
    } catch (e) {
      throw 'Failed to login: $e';
    }
  }

  Future<void> register({required String email, required String password, required String username}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('user').doc(_auth.currentUser?.uid).set({
        'username' : username,
        'email':email,
      });
      // Lakukan sesuatu dengan userCredential.user jika perlu
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong during registration!';
    } catch (e) {
      throw 'Failed to register: $e';
    }
  }
}
