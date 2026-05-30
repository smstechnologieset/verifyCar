import 'package:ethiodrive_history/domain/models/vehicle.dart';
import 'package:ethiodrive_history/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

abstract final class VehicleReportL10n {
  static List<MapEntry<String, String>> ownerRows(
    Vehicle v,
    AppLocalizations l10n,
    DateFormat df,
  ) {
    return [
      MapEntry(l10n.reportFullName, v.ownerName),
      MapEntry(l10n.reportGender, v.gender),
      MapEntry(l10n.reportNationality, v.nationality),
      MapEntry(l10n.reportRegion, v.region),
      MapEntry(l10n.reportCity, v.city),
      MapEntry(l10n.reportSubCity, v.subCity),
      MapEntry(l10n.reportKebele, v.kebele),
      MapEntry(l10n.reportHouseNumber, v.houseNumber),
      MapEntry(l10n.reportPhoneNumber, v.phoneNumber),
      MapEntry(l10n.reportLicenseNumber, v.licenseNumber),
      MapEntry(l10n.reportPreviousLicense, v.previousLicenseNumber),
      MapEntry(l10n.reportLicensePrintedDate, df.format(v.licensePrintedDate)),
    ];
  }

  static List<MapEntry<String, String>> vehicleRows(
    Vehicle v,
    AppLocalizations l10n,
  ) {
    return [
      MapEntry(l10n.reportVehicleType, v.vehicleType),
      MapEntry(l10n.reportMakeCountry, v.makeCountry),
      MapEntry(l10n.reportModel, v.model),
      MapEntry(l10n.reportManufacturingYear, '${v.manufacturingYear}'),
      MapEntry(l10n.reportChassisNumber, v.chassisNumber),
      MapEntry(l10n.reportMotorNumber, v.motorNumber),
      MapEntry(l10n.reportColor, v.color),
      MapEntry(l10n.reportFuelType, v.fuelType),
      MapEntry(l10n.reportHorsePower, v.horsePower),
      MapEntry(l10n.reportWeightCapacity, v.weightCarryingCapacity),
      MapEntry(l10n.reportWeightWithoutCargo, v.vehicleWeightWithoutCargo),
      MapEntry(l10n.reportPassengerCapacity, '${v.passengerCapacity}'),
      MapEntry(l10n.reportMotorCc, '${v.motorCc}'),
      MapEntry(l10n.reportCylinderCount, '${v.cylinderCount}'),
      MapEntry(l10n.reportAuthorizedService, v.authorizedServiceType),
      MapEntry(l10n.reportAxleCount, '${v.axleCount}'),
    ];
  }
}
