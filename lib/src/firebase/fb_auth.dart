import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FBBaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password, String username);

  Future<FirebaseUser> getCurrentUser();

  Future<void> resetPassword(String email);

  Future<void> signOut();
}

class FBAuth extends FBBaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference _usersColection = Firestore.instance.collection('users');

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    if (user != null && user.isEmailVerified) return user;

    return null;
  }

  @override
  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;

    if (user != null && user.isEmailVerified) return user.uid;

    return null;
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String email, String password, username) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await user.sendEmailVerification();
    await createUser(user.uid, {
      email: email,
      username: username,
    });

    return user.uid;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  createUser(uid, user) {
    _usersColection.document().setData(user);
  }

  String processErrorMessage(String codeError) {
    if (codeError == 'ERROR_USER_NOT_FOUND'
        || codeError == 'ERROR_WRONG_PASSWORD')
      return 'Email or password is incorrect';

    if (codeError == 'ERROR_INVALID_EMAIL')
      return 'Email field is invalid';

    if (codeError == 'ERROR_EMAIL_ALREADY_IN_USE')
      return 'Email field is already in use';

    return '';
  }
}