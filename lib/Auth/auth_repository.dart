import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepository{
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String email, required String password}) async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch(e) {
      if (e.code == "weak-pasword") {
        throw Exception("This password is too weak");
      }
      else if (e.code == "email-already-in-use") {
        throw Exception("The account already exists for that email");
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
}