import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_score_flutter_app/models/admin.dart';
import '../utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _error = false;
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');

  late Admin _admin;

  bool get error {
    return _error;
  }

  get authStateStream {
    return auth.authStateChanges();
  }

  Future<void> logIn({String email = '', String password = ''}) async {
    if (email == '' || password == '') return;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
      _error = true;
    } catch (e) {
      _error = true;
      Utils.showSnackbar("Some error occured");
    }
  }

  Future<void> signUp(
      {String email = '',
      String password = '',
      String name = '',
      String collegeName = ''}) async {
    if (email == '' || password == '' || name == '' || collegeName == '') {
      Utils.showSnackbar("Some error occured");
      _error = true;
      return;
    }
    ;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _admin = Admin(name: name, email: email, collegeName: collegeName);
      await _db.add(_admin.toMap());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
      _error = true;
    } catch (e) {
      _error = true;
      print(e);
      Utils.showSnackbar("Some error occured");
    }
  }
}
