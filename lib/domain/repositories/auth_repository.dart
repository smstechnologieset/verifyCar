import 'package:ethiodrive_history/domain/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();
  User? get currentUser;
  Future<AppUser> signInAdmin({required String email, required String password});
  Future<void> signOut();
  Future<AppUser?> getCurrentAppUser();
}
