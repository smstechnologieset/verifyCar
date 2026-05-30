class Vehicle {
  const Vehicle({
    required this.id,
    required this.chassisNumber,
    required this.ownerName,
    required this.gender,
    required this.nationality,
    required this.region,
    required this.city,
    required this.subCity,
    required this.kebele,
    required this.houseNumber,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.previousLicenseNumber,
    required this.licensePrintedDate,
    required this.vehicleType,
    required this.makeCountry,
    required this.model,
    required this.manufacturingYear,
    required this.motorNumber,
    required this.color,
    required this.fuelType,
    required this.horsePower,
    required this.weightCarryingCapacity,
    required this.vehicleWeightWithoutCargo,
    required this.passengerCapacity,
    required this.motorCc,
    required this.cylinderCount,
    required this.authorizedServiceType,
    required this.axleCount,
    this.blockedByBankForSale = false,
  });

  final String id;
  final String chassisNumber;
  final String ownerName;
  final String gender;
  final String nationality;
  final String region;
  final String city;
  final String subCity;
  final String kebele;
  final String houseNumber;
  final String phoneNumber;
  final String licenseNumber;
  final String previousLicenseNumber;
  final DateTime licensePrintedDate;
  final String vehicleType;
  final String makeCountry;
  final String model;
  final int manufacturingYear;
  final String motorNumber;
  final String color;
  final String fuelType;
  final String horsePower;
  final String weightCarryingCapacity;
  final String vehicleWeightWithoutCargo;
  final int passengerCapacity;
  final int motorCc;
  final int cylinderCount;
  final String authorizedServiceType;
  final int axleCount;
  final bool blockedByBankForSale;

  Vehicle copyWith({
    String? id,
    String? chassisNumber,
    String? ownerName,
    String? gender,
    String? nationality,
    String? region,
    String? city,
    String? subCity,
    String? kebele,
    String? houseNumber,
    String? phoneNumber,
    String? licenseNumber,
    String? previousLicenseNumber,
    DateTime? licensePrintedDate,
    String? vehicleType,
    String? makeCountry,
    String? model,
    int? manufacturingYear,
    String? motorNumber,
    String? color,
    String? fuelType,
    String? horsePower,
    String? weightCarryingCapacity,
    String? vehicleWeightWithoutCargo,
    int? passengerCapacity,
    int? motorCc,
    int? cylinderCount,
    String? authorizedServiceType,
    int? axleCount,
    bool? blockedByBankForSale,
  }) {
    return Vehicle(
      id: id ?? this.id,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      ownerName: ownerName ?? this.ownerName,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      region: region ?? this.region,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
      kebele: kebele ?? this.kebele,
      houseNumber: houseNumber ?? this.houseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      previousLicenseNumber: previousLicenseNumber ?? this.previousLicenseNumber,
      licensePrintedDate: licensePrintedDate ?? this.licensePrintedDate,
      vehicleType: vehicleType ?? this.vehicleType,
      makeCountry: makeCountry ?? this.makeCountry,
      model: model ?? this.model,
      manufacturingYear: manufacturingYear ?? this.manufacturingYear,
      motorNumber: motorNumber ?? this.motorNumber,
      color: color ?? this.color,
      fuelType: fuelType ?? this.fuelType,
      horsePower: horsePower ?? this.horsePower,
      weightCarryingCapacity: weightCarryingCapacity ?? this.weightCarryingCapacity,
      vehicleWeightWithoutCargo:
          vehicleWeightWithoutCargo ?? this.vehicleWeightWithoutCargo,
      passengerCapacity: passengerCapacity ?? this.passengerCapacity,
      motorCc: motorCc ?? this.motorCc,
      cylinderCount: cylinderCount ?? this.cylinderCount,
      authorizedServiceType:
          authorizedServiceType ?? this.authorizedServiceType,
      axleCount: axleCount ?? this.axleCount,
      blockedByBankForSale:
          blockedByBankForSale ?? this.blockedByBankForSale,
    );
  }
}
