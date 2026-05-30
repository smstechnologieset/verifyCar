class AppSettings {
  const AppSettings({
    this.paymentAmountEtb = 250,
    this.companyName = 'Ministry of Transport',
    this.companyLogoUrl,
    this.pdfFooterText =
        'Official vehicle history report — Federal Democratic Republic of Ethiopia.',
    this.supportEmail = 'support@mot.gov.et',
    this.supportPhone = '+251 11 000 0000',
  });

  final double paymentAmountEtb;
  final String companyName;
  final String? companyLogoUrl;
  final String pdfFooterText;
  final String supportEmail;
  final String supportPhone;

  AppSettings copyWith({
    double? paymentAmountEtb,
    String? companyName,
    String? companyLogoUrl,
    String? pdfFooterText,
    String? supportEmail,
    String? supportPhone,
  }) {
    return AppSettings(
      paymentAmountEtb: paymentAmountEtb ?? this.paymentAmountEtb,
      companyName: companyName ?? this.companyName,
      companyLogoUrl: companyLogoUrl ?? this.companyLogoUrl,
      pdfFooterText: pdfFooterText ?? this.pdfFooterText,
      supportEmail: supportEmail ?? this.supportEmail,
      supportPhone: supportPhone ?? this.supportPhone,
    );
  }
}
