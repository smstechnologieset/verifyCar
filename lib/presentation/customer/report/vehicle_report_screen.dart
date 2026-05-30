import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/l10n/vehicle_report_l10n.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:ethiodrive_history/presentation/providers/app_providers.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/app_card.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/bank_sale_status_banner.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/info_row.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class VehicleReportScreen extends ConsumerWidget {
  const VehicleReportScreen({
    super.key,
    required this.chassisNumber,
    this.paymentReference,
  });

  final String chassisNumber;
  final String? paymentReference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final vehicleAsync = ref.watch(vehicleByChassisProvider(chassisNumber));
    final settingsAsync = ref.watch(settingsStreamProvider);
    final dateFormat = DateFormat.yMMMd(locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () => context.go('/'),
        ),
        title: Text(l10n.vehicleHistoryReport),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _showPlaceholder(context, l10n.sharePdf),
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () => _showPlaceholder(context, l10n.downloadPdf),
          ),
        ],
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(l10n.errorGenericWithMessage('$e'))),
        data: (vehicle) {
          if (vehicle == null) {
            return Center(child: Text(l10n.vehicleNotFoundShort));
          }
          return settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
                Center(child: Text(l10n.errorLoadSettings('$e'))),
            data: (settings) => SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ReportHeader(
                      companyName: settings.companyName,
                      paymentRef: paymentReference,
                      generatedAt: DateTime.now(),
                      locale: locale,
                    ),
                    const SizedBox(height: 20),
                    _ReportSection(
                      title: l10n.ownerInformation,
                      rows: VehicleReportL10n.ownerRows(
                        vehicle,
                        l10n,
                        dateFormat,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ReportSection(
                      title: l10n.vehicleInformation,
                      rows: VehicleReportL10n.vehicleRows(vehicle, l10n),
                    ),
                    const SizedBox(height: 16),
                    BankSaleStatusBanner(
                      blockedByBankForSale: vehicle.blockedByBankForSale,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      settings.pdfFooterText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _showPlaceholder(context, l10n.downloadPdf),
                            icon: const Icon(Icons.download),
                            label: Text(l10n.downloadPdf),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _showPlaceholder(context, l10n.sharePdf),
                            icon: const Icon(Icons.share),
                            label: Text(l10n.sharePdf),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentTeal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String action) {
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.pdfComingSoon(action))),
    );
  }
}

class _ReportHeader extends StatelessWidget {
  const _ReportHeader({
    required this.companyName,
    required this.generatedAt,
    required this.locale,
    this.paymentRef,
  });

  final String companyName;
  final DateTime generatedAt;
  final String locale;
  final String? paymentRef;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final df = DateFormat.yMMMd(locale).add_Hm();
    return AppCard(
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance,
              color: AppColors.primaryOrange,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            companyName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.officialReport,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.accentTeal,
                ),
          ),
          const SizedBox(height: 16),
          if (paymentRef != null)
            Text(
              l10n.paymentRef(paymentRef!),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Text(
            l10n.generatedAt(df.format(generatedAt)),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
        ],
      ),
    );
  }
}

class _ReportSection extends StatelessWidget {
  const _ReportSection({required this.title, required this.rows});

  final String title;
  final List<MapEntry<String, String>> rows;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: 8),
          const Divider(),
          ...rows.map((e) => InfoRow(label: e.key, value: e.value)),
        ],
      ),
    );
  }
}
