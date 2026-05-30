import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiodrive_history/domain/models/app_settings.dart';

abstract final class SettingsDto {
  static AppSettings fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) return const AppSettings();
    return AppSettings(
      paymentAmountEtb: (data['paymentAmountEtb'] as num?)?.toDouble() ?? 250,
      companyName: data['companyName'] as String? ?? 'Ministry of Transport',
      companyLogoUrl: data['companyLogoUrl'] as String?,
      pdfFooterText: data['pdfFooterText'] as String? ??
          'Official vehicle history report — Federal Democratic Republic of Ethiopia.',
      supportEmail: data['supportEmail'] as String? ?? 'support@mot.gov.et',
      supportPhone: data['supportPhone'] as String? ?? '+251 11 000 0000',
    );
  }

  static Map<String, dynamic> toMap(AppSettings settings) {
    return {
      'paymentAmountEtb': settings.paymentAmountEtb,
      'companyName': settings.companyName,
      'companyLogoUrl': settings.companyLogoUrl,
      'pdfFooterText': settings.pdfFooterText,
      'supportEmail': settings.supportEmail,
      'supportPhone': settings.supportPhone,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
