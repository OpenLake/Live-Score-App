import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:live_score_flutter_app/models/admin.dart';
import '../utils.dart';

class AuthProvider {
  static final auth = FirebaseAuth.instance;
  static final _dbUsers = FirebaseFirestore.instance.collection('users');

  static Future<Admin?> get currentUser async {
    try {
      final userSnapshot = await _dbUsers.doc(auth.currentUser?.email).get();
      if (userSnapshot.exists) {
        return Admin.fromJson(userSnapshot.data()!);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> logIn({String email = '', String password = ''}) async {
    if (email == '' || password == '') return;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    } catch (e) {
      Utils.showSnackbar("Some error occured");
    }
  }

  static Future<void> signUp(
      {String email = '',
      String password = '',
      String name = '',
      String collegeName = ''}) async {
    if (email == '' || password == '' || name == '' || collegeName == '') {
      Utils.showSnackbar("Some error occured");
      return;
    }
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Admin admin = Admin(name: name, email: email, collegeName: collegeName);
      await _dbUsers.doc(email).set(admin.toJson());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    } catch (e) {
      print(e);
      Utils.showSnackbar("Some error occured");
    }
  }

  static Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
      Utils.showSnackbar('Something went wrong');
    }
  }
}
