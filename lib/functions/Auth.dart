import 'package:firebase_auth/firebase_auth.dart';

class MyAuth {
  final _auth = FirebaseAuth.instance;

  void register(String email, String password, Function fn) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        fn(null);
      } else {
        fn('Error');
      }
    } catch (e) {
      print(e);
      fn(e);
    }
  }

  void login(String email, String password, Function fn) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        fn(null);
      } else {
        fn('Error');
      }
    } catch (e) {
      print(e);
      fn(e);
    }
  }

  void logOut(Function fn) async {
    await _auth.signOut();
    fn();
  }

  String getUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return user.email;
      }
    } catch (e) {
      print(e);
    }

    return 'Anonymos';
  }
}
