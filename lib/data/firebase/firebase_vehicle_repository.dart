import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/data/firebase/dto/vehicle_dto.dart';
import 'package:ethiodrive_history/data/firebase/firestore_paths.dart';
import 'package:ethiodrive_history/domain/models/vehicle.dart';
import 'package:ethiodrive_history/domain/repositories/vehicle_repository.dart';

class FirebaseVehicleRepository implements VehicleRepository {
  FirebaseVehicleRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _vehicles =>
      _firestore.collection(FirestorePaths.vehicles);

  @override
  Stream<List<Vehicle>> watchVehicles() {
    return _vehicles
        .orderBy('model')
        .snapshots()
        .map((snap) => snap.docs.map(VehicleDto.fromDoc).toList());
  }

  @override
  Future<Vehicle?> findByChassis(String chassis) async {
    final normalized = chassis.trim().toUpperCase();
    final snap = await _vehicles
        .where('chassisNumber', isEqualTo: normalized)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return VehicleDto.fromDoc(snap.docs.first);
  }

  @override
  Future<String> addVehicle(Vehicle vehicle) async {
    final data = VehicleDto.toMap(vehicle);
    data['createdAt'] = FieldValue.serverTimestamp();
    if (vehicle.id.isNotEmpty &&
        !vehicle.id.startsWith('v') &&
        vehicle.id.length > 10) {
      await _vehicles.doc(vehicle.id).set(data);
      return vehicle.id;
    }
    final doc = await _vehicles.add(data);
    return doc.id;
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    await _vehicles.doc(vehicle.id).update(VehicleDto.toMap(vehicle));
  }

  @override
  Future<void> deleteVehicle(String id) async {
    await _vehicles.doc(id).delete();
  }

  @override
  Future<bool> chassisExists(String chassis, {String? excludeId}) async {
    final normalized = chassis.trim().toUpperCase();
    final snap = await _vehicles
        .where('chassisNumber', isEqualTo: normalized)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return false;
    if (excludeId != null && snap.docs.first.id == excludeId) return false;
    return true;
  }
}
