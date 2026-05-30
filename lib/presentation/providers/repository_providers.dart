import 'package:ethiodrive_history/data/firebase/firebase_auth_repository.dart';
import 'package:ethiodrive_history/data/firebase/firebase_registry_repository.dart';
import 'package:ethiodrive_history/data/firebase/firebase_settings_repository.dart';
import 'package:ethiodrive_history/data/firebase/firebase_vehicle_repository.dart';
import 'package:ethiodrive_history/domain/repositories/auth_repository.dart';
import 'package:ethiodrive_history/domain/repositories/registry_repository.dart';
import 'package:ethiodrive_history/domain/repositories/settings_repository.dart';
import 'package:ethiodrive_history/domain/repositories/vehicle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FirebaseAuthRepository(),
);

final vehicleRepositoryProvider = Provider<VehicleRepository>(
  (ref) => FirebaseVehicleRepository(),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => FirebaseSettingsRepository(),
);

final registryRepositoryProvider = Provider<RegistryRepository>(
  (ref) => FirebaseRegistryRepository(),
);
