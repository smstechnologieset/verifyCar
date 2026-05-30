import 'package:ethiodrive_history/domain/models/app_settings.dart';
import 'package:ethiodrive_history/domain/models/app_user.dart';
import 'package:ethiodrive_history/domain/models/dashboard_stats.dart';
import 'package:ethiodrive_history/domain/models/vehicle.dart';
import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final currentAppUserProvider = FutureProvider<AppUser?>((ref) async {
  ref.watch(authStateProvider);
  return ref.watch(authRepositoryProvider).getCurrentAppUser();
});

final vehiclesStreamProvider = StreamProvider<List<Vehicle>>((ref) {
  return ref.watch(vehicleRepositoryProvider).watchVehicles();
});

final vehicleByChassisProvider =
    FutureProvider.family<Vehicle?, String>((ref, chassis) {
  return ref.watch(vehicleRepositoryProvider).findByChassis(chassis);
});

final settingsStreamProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

final dashboardStatsProvider = StreamProvider<DashboardStats>((ref) {
  final authUser = ref.watch(authStateProvider).valueOrNull;
  if (authUser == null) {
    return Stream.value(const DashboardStats());
  }
  return ref.watch(registryRepositoryProvider).watchDashboardStats();
});
