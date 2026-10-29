import 'package:blog_app/features/auth/data/session_store.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
   AuthRepo(this._auth, this._sessionStore);
  final FirebaseAuth _auth;
  final SessionStore _sessionStore;

  User? get currentUser => _auth.currentUser;

   Stream<User?> get authStateChanges => _auth.authStateChanges();

   Future<void> signIn({required String email, required String password}) async {
     await _auth.signInWithEmailAndPassword(email: email, password: password);
     await _sessionStore.saveEmail(email);
   }

   Future<void> register(
       {required String email, required String password, required String name}) async {
     final credential= await _auth.createUserWithEmailAndPassword(
         email: email, password: password);
     await credential.user!.updateDisplayName(name);
     await _sessionStore.saveEmail(email);
   }

   Future<void> signOut() async {
     await _auth.signOut();
     await _sessionStore.clearEmail();
   }

}