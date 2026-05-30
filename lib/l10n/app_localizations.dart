import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'EthioDrive History'**
  String get appTitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageAmharic.
  ///
  /// In en, this message translates to:
  /// **'አማርኛ'**
  String get languageAmharic;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @ministryOfTransport.
  ///
  /// In en, this message translates to:
  /// **'MINISTRY OF TRANSPORT'**
  String get ministryOfTransport;

  /// No description provided for @federalRegistrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Federal Vehicle Registry — SafeRegistry'**
  String get federalRegistrySubtitle;

  /// No description provided for @officialBadge.
  ///
  /// In en, this message translates to:
  /// **'OFFICIAL'**
  String get officialBadge;

  /// No description provided for @ministryVerified.
  ///
  /// In en, this message translates to:
  /// **'MINISTRY VERIFIED'**
  String get ministryVerified;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'EthioDrive History'**
  String get homeHeadline;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify vehicle ownership and history before you buy. Search the national chassis registry securely.'**
  String get homeSubtitle;

  /// No description provided for @vehicleLookup.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Lookup'**
  String get vehicleLookup;

  /// No description provided for @chassisLabel.
  ///
  /// In en, this message translates to:
  /// **'Chassis number / VIN'**
  String get chassisLabel;

  /// No description provided for @chassisHint.
  ///
  /// In en, this message translates to:
  /// **'Enter chassis number'**
  String get chassisHint;

  /// No description provided for @chassisRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a chassis number'**
  String get chassisRequired;

  /// No description provided for @chassisTooShort.
  ///
  /// In en, this message translates to:
  /// **'Chassis number is too short'**
  String get chassisTooShort;

  /// No description provided for @searchRegistry.
  ///
  /// In en, this message translates to:
  /// **'Search Registry'**
  String get searchRegistry;

  /// No description provided for @searchingRegistry.
  ///
  /// In en, this message translates to:
  /// **'Searching Registry...'**
  String get searchingRegistry;

  /// No description provided for @howVerificationWorks.
  ///
  /// In en, this message translates to:
  /// **'How verification works'**
  String get howVerificationWorks;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Enter chassis number'**
  String get step1Title;

  /// No description provided for @step1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Search the federal vehicle registry database.'**
  String get step1Subtitle;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Confirm vehicle identity'**
  String get step2Title;

  /// No description provided for @step2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Review model and color before proceeding.'**
  String get step2Subtitle;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Secure payment'**
  String get step3Title;

  /// No description provided for @step3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay the official report fee via Chapa gateway.'**
  String get step3Subtitle;

  /// No description provided for @step4Title.
  ///
  /// In en, this message translates to:
  /// **'Full history report'**
  String get step4Title;

  /// No description provided for @step4Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Owner details, vehicle specs, and bank sale status.'**
  String get step4Subtitle;

  /// No description provided for @trustTitle.
  ///
  /// In en, this message translates to:
  /// **'Official & secure'**
  String get trustTitle;

  /// No description provided for @trustBody.
  ///
  /// In en, this message translates to:
  /// **'Data is sourced from the Ministry of Transport registry. Reports include bank lien status and are issued only after verified payment.'**
  String get trustBody;

  /// No description provided for @homeFooter.
  ///
  /// In en, this message translates to:
  /// **'© Ministry of Transport · SafeRegistry v1.0 · Federal Democratic Republic of Ethiopia'**
  String get homeFooter;

  /// No description provided for @navVerification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get navVerification;

  /// No description provided for @navAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get navAdmin;

  /// No description provided for @vehicleFound.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Found'**
  String get vehicleFound;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get modelLabel;

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorLabel;

  /// No description provided for @confirmVehicleQuestion.
  ///
  /// In en, this message translates to:
  /// **'Is this the vehicle you want to view?'**
  String get confirmVehicleQuestion;

  /// No description provided for @viewFullDetails.
  ///
  /// In en, this message translates to:
  /// **'View Full Details'**
  String get viewFullDetails;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @vehicleNotFoundShort.
  ///
  /// In en, this message translates to:
  /// **'Vehicle record not found.'**
  String get vehicleNotFoundShort;

  /// No description provided for @securePayment.
  ///
  /// In en, this message translates to:
  /// **'Secure Payment'**
  String get securePayment;

  /// No description provided for @paymentChapaNotice.
  ///
  /// In en, this message translates to:
  /// **'Payment is processed securely via Chapa. Live Chapa integration coming soon.'**
  String get paymentChapaNotice;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'ORDER SUMMARY'**
  String get orderSummary;

  /// No description provided for @vehicleLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicleLabel;

  /// No description provided for @chassisSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Chassis'**
  String get chassisSummaryLabel;

  /// No description provided for @reportTypeFull.
  ///
  /// In en, this message translates to:
  /// **'Full History Report'**
  String get reportTypeFull;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @chapaGateway.
  ///
  /// In en, this message translates to:
  /// **'Chapa Payment Gateway'**
  String get chapaGateway;

  /// No description provided for @paymentSimulateHint.
  ///
  /// In en, this message translates to:
  /// **'Tap below to complete payment (simulated until Chapa is connected).'**
  String get paymentSimulateHint;

  /// No description provided for @payWithChapa.
  ///
  /// In en, this message translates to:
  /// **'Pay with Chapa'**
  String get payWithChapa;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @vehicleHistoryReport.
  ///
  /// In en, this message translates to:
  /// **'Vehicle History Report'**
  String get vehicleHistoryReport;

  /// No description provided for @officialReport.
  ///
  /// In en, this message translates to:
  /// **'Official Vehicle History Report'**
  String get officialReport;

  /// No description provided for @paymentRef.
  ///
  /// In en, this message translates to:
  /// **'Payment Ref: {reference}'**
  String paymentRef(String reference);

  /// No description provided for @generatedAt.
  ///
  /// In en, this message translates to:
  /// **'Generated: {date}'**
  String generatedAt(String date);

  /// No description provided for @ownerInformation.
  ///
  /// In en, this message translates to:
  /// **'Owner Information'**
  String get ownerInformation;

  /// No description provided for @vehicleInformation.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Information'**
  String get vehicleInformation;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @pdfComingSoon.
  ///
  /// In en, this message translates to:
  /// **'{action} — available after backend integration'**
  String pdfComingSoon(String action);

  /// No description provided for @bankSaleStatus.
  ///
  /// In en, this message translates to:
  /// **'BANK SALE STATUS'**
  String get bankSaleStatus;

  /// No description provided for @blockedByBank.
  ///
  /// In en, this message translates to:
  /// **'Blocked for sale by bank'**
  String get blockedByBank;

  /// No description provided for @notBlockedByBank.
  ///
  /// In en, this message translates to:
  /// **'Not blocked by bank for sale'**
  String get notBlockedByBank;

  /// No description provided for @blockedShort.
  ///
  /// In en, this message translates to:
  /// **'Blocked for sale by bank'**
  String get blockedShort;

  /// No description provided for @notBlockedShort.
  ///
  /// In en, this message translates to:
  /// **'Not blocked by bank'**
  String get notBlockedShort;

  /// No description provided for @adminSignIn.
  ///
  /// In en, this message translates to:
  /// **'ADMIN SIGN IN'**
  String get adminSignIn;

  /// No description provided for @adminSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Secure access to the registry control center'**
  String get adminSignInSubtitle;

  /// No description provided for @adminEmail.
  ///
  /// In en, this message translates to:
  /// **'ADMIN EMAIL'**
  String get adminEmail;

  /// No description provided for @adminEmailHint.
  ///
  /// In en, this message translates to:
  /// **'admin@vehicle.com'**
  String get adminEmailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @signInDashboard.
  ///
  /// In en, this message translates to:
  /// **'Sign In to Dashboard'**
  String get signInDashboard;

  /// No description provided for @federalRegistry.
  ///
  /// In en, this message translates to:
  /// **'FEDERAL VEHICLE REGISTRY'**
  String get federalRegistry;

  /// No description provided for @adminControlCenter.
  ///
  /// In en, this message translates to:
  /// **'Admin Control Center'**
  String get adminControlCenter;

  /// No description provided for @customerApp.
  ///
  /// In en, this message translates to:
  /// **'Customer App'**
  String get customerApp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @adminBadge.
  ///
  /// In en, this message translates to:
  /// **'ADMIN'**
  String get adminBadge;

  /// No description provided for @totalVehicles.
  ///
  /// In en, this message translates to:
  /// **'Total Vehicles'**
  String get totalVehicles;

  /// No description provided for @totalSearches.
  ///
  /// In en, this message translates to:
  /// **'Total Searches'**
  String get totalSearches;

  /// No description provided for @reportsPaid.
  ///
  /// In en, this message translates to:
  /// **'Reports Paid'**
  String get reportsPaid;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @statsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load dashboard statistics. Pull to refresh or sign in again.'**
  String get statsLoadError;

  /// No description provided for @tabVehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get tabVehicles;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @registryRecords.
  ///
  /// In en, this message translates to:
  /// **'REGISTRY RECORDS'**
  String get registryRecords;

  /// No description provided for @recordCount.
  ///
  /// In en, this message translates to:
  /// **'{count} record(s)'**
  String recordCount(int count);

  /// No description provided for @searchVehiclesHint.
  ///
  /// In en, this message translates to:
  /// **'Search by chassis, model, or owner...'**
  String get searchVehiclesHint;

  /// No description provided for @noVehiclesTitle.
  ///
  /// In en, this message translates to:
  /// **'No Vehicle Records Found'**
  String get noVehiclesTitle;

  /// No description provided for @noVehiclesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Register a vehicle to get started.'**
  String get noVehiclesSubtitle;

  /// No description provided for @addNewVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add New Vehicle'**
  String get addNewVehicle;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Vehicle?'**
  String get deleteVehicleTitle;

  /// No description provided for @deleteVehicleBody.
  ///
  /// In en, this message translates to:
  /// **'Remove {model} ({chassis}) from the registry?'**
  String deleteVehicleBody(String model, String chassis);

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @paymentAmountEtb.
  ///
  /// In en, this message translates to:
  /// **'Chapa Payment Amount (ETB)'**
  String get paymentAmountEtb;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @pdfFooterText.
  ///
  /// In en, this message translates to:
  /// **'PDF Footer Text'**
  String get pdfFooterText;

  /// No description provided for @supportEmail.
  ///
  /// In en, this message translates to:
  /// **'Support Email'**
  String get supportEmail;

  /// No description provided for @supportPhone.
  ///
  /// In en, this message translates to:
  /// **'Support Phone'**
  String get supportPhone;

  /// No description provided for @logoUploadSoon.
  ///
  /// In en, this message translates to:
  /// **'Company logo upload — Firebase Storage integration coming soon.'**
  String get logoUploadSoon;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @invalidPaymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid payment amount'**
  String get invalidPaymentAmount;

  /// No description provided for @editVehicle.
  ///
  /// In en, this message translates to:
  /// **'Edit Vehicle'**
  String get editVehicle;

  /// No description provided for @registerVehicle.
  ///
  /// In en, this message translates to:
  /// **'Register Vehicle'**
  String get registerVehicle;

  /// No description provided for @ownerDetails.
  ///
  /// In en, this message translates to:
  /// **'Owner Details'**
  String get ownerDetails;

  /// No description provided for @vehicleDetails.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Details'**
  String get vehicleDetails;

  /// No description provided for @licensePrintedDate.
  ///
  /// In en, this message translates to:
  /// **'License Printed Date'**
  String get licensePrintedDate;

  /// No description provided for @blockedForSaleByBank.
  ///
  /// In en, this message translates to:
  /// **'Blocked for sale by bank'**
  String get blockedForSaleByBank;

  /// No description provided for @blockedForSaleHintOn.
  ///
  /// In en, this message translates to:
  /// **'This vehicle cannot be sold until the bank lien is cleared.'**
  String get blockedForSaleHintOn;

  /// No description provided for @blockedForSaleHintOff.
  ///
  /// In en, this message translates to:
  /// **'Vehicle is clear for sale (not blocked by bank).'**
  String get blockedForSaleHintOff;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @chassisMustBeUnique.
  ///
  /// In en, this message translates to:
  /// **'Chassis number must be unique'**
  String get chassisMustBeUnique;

  /// No description provided for @vehicleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Vehicle updated'**
  String get vehicleUpdated;

  /// No description provided for @vehicleRegistered.
  ///
  /// In en, this message translates to:
  /// **'Vehicle registered'**
  String get vehicleRegistered;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @fieldInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get fieldInvalidNumber;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get fieldGender;

  /// No description provided for @fieldNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get fieldNationality;

  /// No description provided for @fieldRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get fieldRegion;

  /// No description provided for @fieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get fieldCity;

  /// No description provided for @fieldSubCity.
  ///
  /// In en, this message translates to:
  /// **'Sub City'**
  String get fieldSubCity;

  /// No description provided for @fieldKebele.
  ///
  /// In en, this message translates to:
  /// **'Kebele'**
  String get fieldKebele;

  /// No description provided for @fieldHouseNumber.
  ///
  /// In en, this message translates to:
  /// **'House Number'**
  String get fieldHouseNumber;

  /// No description provided for @fieldPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get fieldPhoneNumber;

  /// No description provided for @fieldLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get fieldLicenseNumber;

  /// No description provided for @fieldPreviousLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Previous License Number'**
  String get fieldPreviousLicenseNumber;

  /// No description provided for @fieldVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get fieldVehicleType;

  /// No description provided for @fieldMakeCountry.
  ///
  /// In en, this message translates to:
  /// **'Make Country'**
  String get fieldMakeCountry;

  /// No description provided for @fieldModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get fieldModel;

  /// No description provided for @fieldYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get fieldYear;

  /// No description provided for @fieldChassisNumber.
  ///
  /// In en, this message translates to:
  /// **'Chassis Number'**
  String get fieldChassisNumber;

  /// No description provided for @fieldMotorNumber.
  ///
  /// In en, this message translates to:
  /// **'Motor Number'**
  String get fieldMotorNumber;

  /// No description provided for @fieldColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get fieldColor;

  /// No description provided for @fieldFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get fieldFuelType;

  /// No description provided for @fieldHorsePower.
  ///
  /// In en, this message translates to:
  /// **'Horse Power'**
  String get fieldHorsePower;

  /// No description provided for @fieldWeightCarryingCapacity.
  ///
  /// In en, this message translates to:
  /// **'Weight Carrying Capacity'**
  String get fieldWeightCarryingCapacity;

  /// No description provided for @fieldWeightWithoutCargo.
  ///
  /// In en, this message translates to:
  /// **'Weight Without Cargo'**
  String get fieldWeightWithoutCargo;

  /// No description provided for @fieldPassengerCapacity.
  ///
  /// In en, this message translates to:
  /// **'Passenger Capacity'**
  String get fieldPassengerCapacity;

  /// No description provided for @fieldMotorCc.
  ///
  /// In en, this message translates to:
  /// **'Motor CC'**
  String get fieldMotorCc;

  /// No description provided for @fieldCylinderCount.
  ///
  /// In en, this message translates to:
  /// **'Cylinder Count'**
  String get fieldCylinderCount;

  /// No description provided for @fieldAuthorizedServiceType.
  ///
  /// In en, this message translates to:
  /// **'Authorized Service Type'**
  String get fieldAuthorizedServiceType;

  /// No description provided for @fieldAxleCount.
  ///
  /// In en, this message translates to:
  /// **'Axle Count'**
  String get fieldAxleCount;

  /// No description provided for @reportFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get reportFullName;

  /// No description provided for @reportGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get reportGender;

  /// No description provided for @reportNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get reportNationality;

  /// No description provided for @reportRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get reportRegion;

  /// No description provided for @reportCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get reportCity;

  /// No description provided for @reportSubCity.
  ///
  /// In en, this message translates to:
  /// **'Sub City'**
  String get reportSubCity;

  /// No description provided for @reportKebele.
  ///
  /// In en, this message translates to:
  /// **'Kebele'**
  String get reportKebele;

  /// No description provided for @reportHouseNumber.
  ///
  /// In en, this message translates to:
  /// **'House Number'**
  String get reportHouseNumber;

  /// No description provided for @reportPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get reportPhoneNumber;

  /// No description provided for @reportLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get reportLicenseNumber;

  /// No description provided for @reportPreviousLicense.
  ///
  /// In en, this message translates to:
  /// **'Previous License Number'**
  String get reportPreviousLicense;

  /// No description provided for @reportLicensePrintedDate.
  ///
  /// In en, this message translates to:
  /// **'License Printed Date'**
  String get reportLicensePrintedDate;

  /// No description provided for @reportVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get reportVehicleType;

  /// No description provided for @reportMakeCountry.
  ///
  /// In en, this message translates to:
  /// **'Make Country'**
  String get reportMakeCountry;

  /// No description provided for @reportModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get reportModel;

  /// No description provided for @reportManufacturingYear.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing Year'**
  String get reportManufacturingYear;

  /// No description provided for @reportChassisNumber.
  ///
  /// In en, this message translates to:
  /// **'Chassis Number'**
  String get reportChassisNumber;

  /// No description provided for @reportMotorNumber.
  ///
  /// In en, this message translates to:
  /// **'Motor Number'**
  String get reportMotorNumber;

  /// No description provided for @reportColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get reportColor;

  /// No description provided for @reportFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get reportFuelType;

  /// No description provided for @reportHorsePower.
  ///
  /// In en, this message translates to:
  /// **'Horse Power'**
  String get reportHorsePower;

  /// No description provided for @reportWeightCapacity.
  ///
  /// In en, this message translates to:
  /// **'Weight Carrying Capacity'**
  String get reportWeightCapacity;

  /// No description provided for @reportWeightWithoutCargo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Weight Without Cargo'**
  String get reportWeightWithoutCargo;

  /// No description provided for @reportPassengerCapacity.
  ///
  /// In en, this message translates to:
  /// **'Passenger Capacity'**
  String get reportPassengerCapacity;

  /// No description provided for @reportMotorCc.
  ///
  /// In en, this message translates to:
  /// **'Motor CC'**
  String get reportMotorCc;

  /// No description provided for @reportCylinderCount.
  ///
  /// In en, this message translates to:
  /// **'Cylinder Count'**
  String get reportCylinderCount;

  /// No description provided for @reportAuthorizedService.
  ///
  /// In en, this message translates to:
  /// **'Authorized Service Type'**
  String get reportAuthorizedService;

  /// No description provided for @reportAxleCount.
  ///
  /// In en, this message translates to:
  /// **'Axle Count'**
  String get reportAxleCount;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get errorInvalidEmail;

  /// No description provided for @errorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Contact your administrator.'**
  String get errorUserDisabled;

  /// No description provided for @errorWrongCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password. Please try again.'**
  String get errorWrongCredentials;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many sign-in attempts. Please wait a moment and try again.'**
  String get errorTooManyRequests;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your internet connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorNotAdmin.
  ///
  /// In en, this message translates to:
  /// **'This account is not authorized for admin access.'**
  String get errorNotAdmin;

  /// No description provided for @errorSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed. Please check your credentials and try again.'**
  String get errorSignInFailed;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this action.'**
  String get errorPermissionDenied;

  /// No description provided for @errorRegistryUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The registry is temporarily unavailable. Please try again shortly.'**
  String get errorRegistryUnavailable;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorVehicleNotFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicle was found for this chassis number. Please check the number and try again.'**
  String get errorVehicleNotFound;

  /// No description provided for @errorSearchUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach the vehicle registry. Check your connection and try again.'**
  String get errorSearchUnavailable;

  /// No description provided for @errorSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {message}'**
  String errorSaveFailed(String message);

  /// No description provided for @errorDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {message}'**
  String errorDeleteFailed(String message);

  /// No description provided for @errorLoadVehicles.
  ///
  /// In en, this message translates to:
  /// **'Error loading vehicles: {message}'**
  String errorLoadVehicles(String message);

  /// No description provided for @errorLoadSettings.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {message}'**
  String errorLoadSettings(String message);

  /// No description provided for @errorGenericWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorGenericWithMessage(String message);

  /// No description provided for @dashPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get dashPlaceholder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
