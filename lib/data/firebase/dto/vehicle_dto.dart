import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/domain/models/vehicle.dart';

abstract final class VehicleDto {
  static Vehicle fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Vehicle(
      id: doc.id,
      chassisNumber: data['chassisNumber'] as String,
      ownerName: data['ownerName'] as String,
      gender: data['gender'] as String,
      nationality: data['nationality'] as String,
      region: data['region'] as String,
      city: data['city'] as String,
      subCity: data['subCity'] as String,
      kebele: data['kebele'] as String,
      houseNumber: data['houseNumber'] as String,
      phoneNumber: data['phoneNumber'] as String,
      licenseNumber: data['licenseNumber'] as String,
      previousLicenseNumber: data['previousLicenseNumber'] as String,
      licensePrintedDate:
          (data['licensePrintedDate'] as Timestamp).toDate(),
      vehicleType: data['vehicleType'] as String,
      makeCountry: data['makeCountry'] as String,
      model: data['model'] as String,
      manufacturingYear: data['manufacturingYear'] as int,
      motorNumber: data['motorNumber'] as String,
      color: data['color'] as String,
      fuelType: data['fuelType'] as String,
      horsePower: data['horsePower'] as String,
      weightCarryingCapacity: data['weightCarryingCapacity'] as String,
      vehicleWeightWithoutCargo: data['vehicleWeightWithoutCargo'] as String,
      passengerCapacity: data['passengerCapacity'] as int,
      motorCc: data['motorCc'] as int,
      cylinderCount: data['cylinderCount'] as int,
      authorizedServiceType: data['authorizedServiceType'] as String,
      axleCount: data['axleCount'] as int,
      blockedByBankForSale: data['blockedByBankForSale'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    return {
      'chassisNumber': vehicle.chassisNumber.trim().toUpperCase(),
      'ownerName': vehicle.ownerName,
      'gender': vehicle.gender,
      'nationality': vehicle.nationality,
      'region': vehicle.region,
      'city': vehicle.city,
      'subCity': vehicle.subCity,
      'kebele': vehicle.kebele,
      'houseNumber': vehicle.houseNumber,
      'phoneNumber': vehicle.phoneNumber,
      'licenseNumber': vehicle.licenseNumber,
      'previousLicenseNumber': vehicle.previousLicenseNumber,
      'licensePrintedDate': Timestamp.fromDate(vehicle.licensePrintedDate),
      'vehicleType': vehicle.vehicleType,
      'makeCountry': vehicle.makeCountry,
      'model': vehicle.model,
      'manufacturingYear': vehicle.manufacturingYear,
      'motorNumber': vehicle.motorNumber,
      'color': vehicle.color,
      'fuelType': vehicle.fuelType,
      'horsePower': vehicle.horsePower,
      'weightCarryingCapacity': vehicle.weightCarryingCapacity,
      'vehicleWeightWithoutCargo': vehicle.vehicleWeightWithoutCargo,
      'passengerCapacity': vehicle.passengerCapacity,
      'motorCc': vehicle.motorCc,
      'cylinderCount': vehicle.cylinderCount,
      'authorizedServiceType': vehicle.authorizedServiceType,
      'axleCount': vehicle.axleCount,
      'blockedByBankForSale': vehicle.blockedByBankForSale,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
