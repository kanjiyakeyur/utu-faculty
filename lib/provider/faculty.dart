import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Faculty with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  String _userId;
  String _email;
  String _name;
  String get userid {
    return _userId;
  }

  String get name {
    return _name;
  }

  Map<String, String> get details {
    return {'name': _name, 'mailId': _email, 'uid': _userId};
  }

  Future<void> fatchFacultyDetails() async {
    try {
      var re = await FirebaseAuth.instance.currentUser();
      _userId = re.uid;

      final firestore = Firestore.instance.collection('faculty');
      var data = await firestore.document('$_userId').get();
      if (data.data == null) {
        await FirebaseAuth.instance.signOut();
        throw 'Not Authorize to Login';
      }
      _email = data.data['email'];
      _name = data.data['name'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    AuthResult _authResulte;
    _authResulte = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _email = _authResulte.user.email;
    _userId = _authResulte.user.uid;
    await fatchFacultyDetails();
  }

  void logout() {
    _userId = '';
    _email = '';
    _name = '';
    _auth.signOut();
  }
//
//  Future<void> tryAutoLogin() async {
//    try {
//      final prfs = await SharedPreferences.getInstance();
//      if (!prfs.containsKey('userData')) {
//        return false;
//      }
//      final exterctedData =
//          json.decode(prfs.get('userData')) as Map<String, Object>;
//      final expireDate = DateTime.parse(exterctedData['expireDate']);
//      if (expireDate.isBefore(DateTime.now())) {
//        return false;
//      }
//      _token = exterctedData['token'];
//      _userId = exterctedData['userid'];
//      _expireDate = expireDate;
//      await fatchFacultyDetails();
//      notifyListeners();
//      _autoLogout();
//      return true;
//    } catch (error) {
//      logout();
//      throw error;
//    }
//  }
//
//  Future<void> logout() async {
//    _token = null;
//    _userId = null;
//    _expireDate = null;
//    if (_authTimer != null) {
//      _authTimer.cancel();
//      _authTimer = null;
//    }
//    notifyListeners();
//    final prefs = await SharedPreferences.getInstance();
//    prefs.clear();
//  }
//
//  void _autoLogout() {
//    if (_authTimer != null) {
//      _authTimer.cancel();
//    }
//    final timeToExprie = _expireDate.difference(DateTime.now()).inSeconds;
//    _authTimer = Timer(Duration(seconds: timeToExprie), logout);
//  }
}
