import 'package:ethiodrive_history/domain/models/dashboard_stats.dart';

abstract class RegistryRepository {
  Stream<DashboardStats> watchDashboardStats();
  Future<void> logSearch({required String chassis, required bool found});
  Future<void> recordPayment({
    required String chassis,
    required double amountEtb,
    required String reference,
  });
}
