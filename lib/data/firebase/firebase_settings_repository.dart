import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/data/firebase/dto/settings_dto.dart';
import 'package:ethiodrive_history/data/firebase/firestore_paths.dart';
import 'package:ethiodrive_history/domain/models/app_settings.dart';
import 'package:ethiodrive_history/domain/repositories/settings_repository.dart';

class FirebaseSettingsRepository implements SettingsRepository {
  FirebaseSettingsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> get _doc => _firestore
      .collection(FirestorePaths.settings)
      .doc(FirestorePaths.settingsDoc);

  @override
  Stream<AppSettings> watchSettings() {
    return _doc.snapshots().map(SettingsDto.fromDoc);
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    await _doc.set(SettingsDto.toMap(settings), SetOptions(merge: true));
  }
}
