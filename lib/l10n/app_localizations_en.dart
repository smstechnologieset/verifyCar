// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EthioDrive History';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageAmharic => 'አማርኛ';

  @override
  String get languageLabel => 'Language';

  @override
  String get ministryOfTransport => 'MINISTRY OF TRANSPORT';

  @override
  String get federalRegistrySubtitle =>
      'Federal Vehicle Registry — SafeRegistry';

  @override
  String get officialBadge => 'OFFICIAL';

  @override
  String get ministryVerified => 'MINISTRY VERIFIED';

  @override
  String get homeHeadline => 'EthioDrive History';

  @override
  String get homeSubtitle =>
      'Verify vehicle ownership and history before you buy. Search the national chassis registry securely.';

  @override
  String get vehicleLookup => 'Vehicle Lookup';

  @override
  String get chassisLabel => 'Chassis number / VIN';

  @override
  String get chassisHint => 'Enter chassis number';

  @override
  String get chassisRequired => 'Please enter a chassis number';

  @override
  String get chassisTooShort => 'Chassis number is too short';

  @override
  String get searchRegistry => 'Search Registry';

  @override
  String get searchingRegistry => 'Searching Registry...';

  @override
  String get howVerificationWorks => 'How verification works';

  @override
  String get step1Title => 'Enter chassis number';

  @override
  String get step1Subtitle => 'Search the federal vehicle registry database.';

  @override
  String get step2Title => 'Confirm vehicle identity';

  @override
  String get step2Subtitle => 'Review model and color before proceeding.';

  @override
  String get step3Title => 'Secure payment';

  @override
  String get step3Subtitle => 'Pay the official report fee via Chapa gateway.';

  @override
  String get step4Title => 'Full history report';

  @override
  String get step4Subtitle =>
      'Owner details, vehicle specs, and bank sale status.';

  @override
  String get trustTitle => 'Official & secure';

  @override
  String get trustBody =>
      'Data is sourced from the Ministry of Transport registry. Reports include bank lien status and are issued only after verified payment.';

  @override
  String get homeFooter =>
      '© Ministry of Transport · SafeRegistry v1.0 · Federal Democratic Republic of Ethiopia';

  @override
  String get navVerification => 'Verification';

  @override
  String get navAdmin => 'Admin Panel';

  @override
  String get vehicleFound => 'Vehicle Found';

  @override
  String get modelLabel => 'Model';

  @override
  String get colorLabel => 'Color';

  @override
  String get confirmVehicleQuestion => 'Is this the vehicle you want to view?';

  @override
  String get viewFullDetails => 'View Full Details';

  @override
  String get cancel => 'Cancel';

  @override
  String get vehicleNotFoundShort => 'Vehicle record not found.';

  @override
  String get securePayment => 'Secure Payment';

  @override
  String get paymentChapaNotice =>
      'Payment is processed securely via Chapa. Live Chapa integration coming soon.';

  @override
  String get orderSummary => 'ORDER SUMMARY';

  @override
  String get vehicleLabel => 'Vehicle';

  @override
  String get chassisSummaryLabel => 'Chassis';

  @override
  String get reportTypeFull => 'Full History Report';

  @override
  String get total => 'Total';

  @override
  String get chapaGateway => 'Chapa Payment Gateway';

  @override
  String get paymentSimulateHint =>
      'Tap below to complete payment (simulated until Chapa is connected).';

  @override
  String get payWithChapa => 'Pay with Chapa';

  @override
  String get processing => 'Processing...';

  @override
  String get vehicleHistoryReport => 'Vehicle History Report';

  @override
  String get officialReport => 'Official Vehicle History Report';

  @override
  String paymentRef(String reference) {
    return 'Payment Ref: $reference';
  }

  @override
  String generatedAt(String date) {
    return 'Generated: $date';
  }

  @override
  String get ownerInformation => 'Owner Information';

  @override
  String get vehicleInformation => 'Vehicle Information';

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String pdfComingSoon(String action) {
    return '$action — available after backend integration';
  }

  @override
  String get bankSaleStatus => 'BANK SALE STATUS';

  @override
  String get blockedByBank => 'Blocked for sale by bank';

  @override
  String get notBlockedByBank => 'Not blocked by bank for sale';

  @override
  String get blockedShort => 'Blocked for sale by bank';

  @override
  String get notBlockedShort => 'Not blocked by bank';

  @override
  String get adminSignIn => 'ADMIN SIGN IN';

  @override
  String get adminSignInSubtitle =>
      'Secure access to the registry control center';

  @override
  String get adminEmail => 'ADMIN EMAIL';

  @override
  String get adminEmailHint => 'admin@vehicle.com';

  @override
  String get password => 'PASSWORD';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get signInDashboard => 'Sign In to Dashboard';

  @override
  String get federalRegistry => 'FEDERAL VEHICLE REGISTRY';

  @override
  String get adminControlCenter => 'Admin Control Center';

  @override
  String get customerApp => 'Customer App';

  @override
  String get logout => 'Logout';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get totalVehicles => 'Total Vehicles';

  @override
  String get totalSearches => 'Total Searches';

  @override
  String get reportsPaid => 'Reports Paid';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get statsLoadError =>
      'Could not load dashboard statistics. Pull to refresh or sign in again.';

  @override
  String get tabVehicles => 'Vehicles';

  @override
  String get tabSettings => 'Settings';

  @override
  String get addVehicle => 'Add Vehicle';

  @override
  String get registryRecords => 'REGISTRY RECORDS';

  @override
  String recordCount(int count) {
    return '$count record(s)';
  }

  @override
  String get searchVehiclesHint => 'Search by chassis, model, or owner...';

  @override
  String get noVehiclesTitle => 'No Vehicle Records Found';

  @override
  String get noVehiclesSubtitle => 'Register a vehicle to get started.';

  @override
  String get addNewVehicle => 'Add New Vehicle';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteVehicleTitle => 'Delete Vehicle?';

  @override
  String deleteVehicleBody(String model, String chassis) {
    return 'Remove $model ($chassis) from the registry?';
  }

  @override
  String get systemSettings => 'System Settings';

  @override
  String get paymentAmountEtb => 'Chapa Payment Amount (ETB)';

  @override
  String get companyName => 'Company Name';

  @override
  String get pdfFooterText => 'PDF Footer Text';

  @override
  String get supportEmail => 'Support Email';

  @override
  String get supportPhone => 'Support Phone';

  @override
  String get logoUploadSoon =>
      'Company logo upload — Firebase Storage integration coming soon.';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get invalidPaymentAmount => 'Enter a valid payment amount';

  @override
  String get editVehicle => 'Edit Vehicle';

  @override
  String get registerVehicle => 'Register Vehicle';

  @override
  String get ownerDetails => 'Owner Details';

  @override
  String get vehicleDetails => 'Vehicle Details';

  @override
  String get licensePrintedDate => 'License Printed Date';

  @override
  String get blockedForSaleByBank => 'Blocked for sale by bank';

  @override
  String get blockedForSaleHintOn =>
      'This vehicle cannot be sold until the bank lien is cleared.';

  @override
  String get blockedForSaleHintOff =>
      'Vehicle is clear for sale (not blocked by bank).';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get register => 'Register';

  @override
  String get chassisMustBeUnique => 'Chassis number must be unique';

  @override
  String get vehicleUpdated => 'Vehicle updated';

  @override
  String get vehicleRegistered => 'Vehicle registered';

  @override
  String get fieldRequired => 'Required';

  @override
  String get fieldInvalidNumber => 'Enter a valid number';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldGender => 'Gender';

  @override
  String get fieldNationality => 'Nationality';

  @override
  String get fieldRegion => 'Region';

  @override
  String get fieldCity => 'City';

  @override
  String get fieldSubCity => 'Sub City';

  @override
  String get fieldKebele => 'Kebele';

  @override
  String get fieldHouseNumber => 'House Number';

  @override
  String get fieldPhoneNumber => 'Phone Number';

  @override
  String get fieldLicenseNumber => 'License Number';

  @override
  String get fieldPreviousLicenseNumber => 'Previous License Number';

  @override
  String get fieldVehicleType => 'Vehicle Type';

  @override
  String get fieldMakeCountry => 'Make Country';

  @override
  String get fieldModel => 'Model';

  @override
  String get fieldYear => 'Year';

  @override
  String get fieldChassisNumber => 'Chassis Number';

  @override
  String get fieldMotorNumber => 'Motor Number';

  @override
  String get fieldColor => 'Color';

  @override
  String get fieldFuelType => 'Fuel Type';

  @override
  String get fieldHorsePower => 'Horse Power';

  @override
  String get fieldWeightCarryingCapacity => 'Weight Carrying Capacity';

  @override
  String get fieldWeightWithoutCargo => 'Weight Without Cargo';

  @override
  String get fieldPassengerCapacity => 'Passenger Capacity';

  @override
  String get fieldMotorCc => 'Motor CC';

  @override
  String get fieldCylinderCount => 'Cylinder Count';

  @override
  String get fieldAuthorizedServiceType => 'Authorized Service Type';

  @override
  String get fieldAxleCount => 'Axle Count';

  @override
  String get reportFullName => 'Full Name';

  @override
  String get reportGender => 'Gender';

  @override
  String get reportNationality => 'Nationality';

  @override
  String get reportRegion => 'Region';

  @override
  String get reportCity => 'City';

  @override
  String get reportSubCity => 'Sub City';

  @override
  String get reportKebele => 'Kebele';

  @override
  String get reportHouseNumber => 'House Number';

  @override
  String get reportPhoneNumber => 'Phone Number';

  @override
  String get reportLicenseNumber => 'License Number';

  @override
  String get reportPreviousLicense => 'Previous License Number';

  @override
  String get reportLicensePrintedDate => 'License Printed Date';

  @override
  String get reportVehicleType => 'Vehicle Type';

  @override
  String get reportMakeCountry => 'Make Country';

  @override
  String get reportModel => 'Model';

  @override
  String get reportManufacturingYear => 'Manufacturing Year';

  @override
  String get reportChassisNumber => 'Chassis Number';

  @override
  String get reportMotorNumber => 'Motor Number';

  @override
  String get reportColor => 'Color';

  @override
  String get reportFuelType => 'Fuel Type';

  @override
  String get reportHorsePower => 'Horse Power';

  @override
  String get reportWeightCapacity => 'Weight Carrying Capacity';

  @override
  String get reportWeightWithoutCargo => 'Vehicle Weight Without Cargo';

  @override
  String get reportPassengerCapacity => 'Passenger Capacity';

  @override
  String get reportMotorCc => 'Motor CC';

  @override
  String get reportCylinderCount => 'Cylinder Count';

  @override
  String get reportAuthorizedService => 'Authorized Service Type';

  @override
  String get reportAxleCount => 'Axle Count';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get errorUserDisabled =>
      'This account has been disabled. Contact your administrator.';

  @override
  String get errorWrongCredentials =>
      'Incorrect email or password. Please try again.';

  @override
  String get errorTooManyRequests =>
      'Too many sign-in attempts. Please wait a moment and try again.';

  @override
  String get errorNetwork =>
      'Network error. Check your internet connection and try again.';

  @override
  String get errorNotAdmin =>
      'This account is not authorized for admin access.';

  @override
  String get errorSignInFailed =>
      'Sign in failed. Please check your credentials and try again.';

  @override
  String get errorPermissionDenied =>
      'You do not have permission to perform this action.';

  @override
  String get errorRegistryUnavailable =>
      'The registry is temporarily unavailable. Please try again shortly.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorVehicleNotFound =>
      'No vehicle was found for this chassis number. Please check the number and try again.';

  @override
  String get errorSearchUnavailable =>
      'Unable to reach the vehicle registry. Check your connection and try again.';

  @override
  String errorSaveFailed(String message) {
    return 'Save failed: $message';
  }

  @override
  String errorDeleteFailed(String message) {
    return 'Delete failed: $message';
  }

  @override
  String errorLoadVehicles(String message) {
    return 'Error loading vehicles: $message';
  }

  @override
  String errorLoadSettings(String message) {
    return 'Error loading settings: $message';
  }

  @override
  String errorGenericWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get dashPlaceholder => '—';
}
