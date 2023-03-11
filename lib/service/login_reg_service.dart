import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception("Dataaaaaa incorrect or empty");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class RegService {
  Future<void> signUp({required String email, required String password}) async {

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      if (e.code == "weak-pasword") {
        throw Exception("This password is too weak");
      } else if (e.code == "email-already-in-use") {
        throw Exception("The account already exists for that email");
      } else {
        throw Exception("Data incorrect or empty");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}