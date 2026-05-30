import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/data/firebase/dto/app_user_dto.dart';
import 'package:ethiodrive_history/data/firebase/firestore_paths.dart';
import 'package:ethiodrive_history/domain/models/app_user.dart';
import 'package:ethiodrive_history/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<AppUser> signInAdmin({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user?.uid;
    if (uid == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'Authentication failed.',
      );
    }

    final appUser = await _fetchUser(uid);
    if (appUser == null || !appUser.isAdmin) {
      await _auth.signOut();
      throw FirebaseAuthException(
        code: 'permission-denied',
        message: 'This account does not have admin access.',
      );
    }
    return appUser;
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<AppUser?> getCurrentAppUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final user = await _fetchUser(uid);
    if (user == null || !user.isAdmin) return null;
    return user;
  }

  Future<AppUser?> _fetchUser(String uid) async {
    final doc = await _firestore
        .collection(FirestorePaths.users)
        .doc(uid)
        .get();
    if (!doc.exists) return null;
    return AppUserDto.fromDoc(doc);
  }
}
