import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get stream
  Stream<User> get getStream {
    return _auth.authStateChanges();
  }

  User get currentUser {
    return _auth.currentUser;
  }

  //sign in
  Future signIn(email, password) {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  //sign out
  Future signOut() {
    try {
      return _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  //register, this returns null if SUCCESS, and an error message if Failed
  Future register(email, password) async {
    try {
      return _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
