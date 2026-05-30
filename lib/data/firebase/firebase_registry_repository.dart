import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/data/firebase/firestore_paths.dart';
import 'package:ethiodrive_history/domain/models/dashboard_stats.dart';
import 'package:ethiodrive_history/domain/repositories/registry_repository.dart';

class FirebaseRegistryRepository implements RegistryRepository {
  FirebaseRegistryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> get _stats => _firestore
      .collection(FirestorePaths.stats)
      .doc(FirestorePaths.statsDoc);

  @override
  Stream<DashboardStats> watchDashboardStats() {
    final vehicles$ =
        _firestore.collection(FirestorePaths.vehicles).snapshots();
    final stats$ = _stats.snapshots();

    return Stream<DashboardStats>.multi((controller) {
      QuerySnapshot<Map<String, dynamic>>? latestVehicles;
      DocumentSnapshot<Map<String, dynamic>>? latestStats;
      var statsReadable = true;

      void emit() {
        final statsData =
            statsReadable ? (latestStats?.data() ?? {}) : <String, dynamic>{};
        controller.add(
          DashboardStats(
            totalVehicles: latestVehicles?.size ?? 0,
            totalSearches:
                (statsData['totalSearches'] as num?)?.toInt() ?? 0,
            totalPaidReports:
                (statsData['totalPaidReports'] as num?)?.toInt() ?? 0,
            totalRevenueEtb:
                (statsData['totalRevenueEtb'] as num?)?.toDouble() ?? 0,
          ),
        );
      }

      final subVehicles = vehicles$.listen(
        (snap) {
          latestVehicles = snap;
          emit();
        },
        onError: controller.addError,
      );

      final subStats = stats$.listen(
        (snap) {
          latestStats = snap;
          emit();
        },
        onError: (_) {
          statsReadable = false;
          emit();
        },
      );

      controller.onCancel = () async {
        await subVehicles.cancel();
        await subStats.cancel();
      };
    });
  }

  /// Creates stats doc if missing without a read (avoids permission issues).
  Future<void> _ensureStatsDoc() async {
    try {
      await _stats.update({
        'totalSearches': FieldValue.increment(0),
      });
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        await _stats.set({
          'totalSearches': 0,
          'totalPaidReports': 0,
          'totalRevenueEtb': 0,
        });
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> logSearch({required String chassis, required bool found}) async {
    await _ensureStatsDoc();
    await _firestore.collection(FirestorePaths.searchLogs).add({
      'chassisNumber': chassis.trim().toUpperCase(),
      'found': found,
      'searchedAt': FieldValue.serverTimestamp(),
    });
    await _stats.update({'totalSearches': FieldValue.increment(1)});
  }

  @override
  Future<void> recordPayment({
    required String chassis,
    required double amountEtb,
    required String reference,
  }) async {
    await _ensureStatsDoc();
    await _firestore.collection(FirestorePaths.payments).add({
      'chassisNumber': chassis.trim().toUpperCase(),
      'amountEtb': amountEtb,
      'reference': reference,
      'status': 'completed',
      'paidAt': FieldValue.serverTimestamp(),
    });
    await _stats.update({
      'totalPaidReports': FieldValue.increment(1),
      'totalRevenueEtb': FieldValue.increment(amountEtb),
    });
  }
}
