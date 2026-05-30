import 'package:ethiodrive_history/domain/models/vehicle.dart';

abstract class VehicleRepository {
  Stream<List<Vehicle>> watchVehicles();
  Future<Vehicle?> findByChassis(String chassis);
  Future<String> addVehicle(Vehicle vehicle);
  Future<void> updateVehicle(Vehicle vehicle);
  Future<void> deleteVehicle(String id);
  Future<bool> chassisExists(String chassis, {String? excludeId});
}
