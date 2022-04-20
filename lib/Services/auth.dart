import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> signUp(String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  Future<void> registerUser(String? email, String? password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      if (userCredential.toString().isNotEmpty){
        User? user = _auth.currentUser;
        assert(user != null);

        // this is just an example to show how you can add it to firestore database. You don't have to do it while signing up,
        // because you take the username in the next form, so just auth register for now, but save the values of email and password
        // so that you can add all these fields inside the database as well, once you have the username. 
        FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          "email": email,
          "member": "customer",
          "pass": password,
          "timestamp": DateTime.now().toUtc().toString(),
          "uid": user.uid,
          "user": 'momer',
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        // set error message to show in the front end
      }

      else if (e.code == "weak-password") {
        // set error message to show in the front end
      }

      else {
        // set error message to show in the front end
      }
    }
  }

}
