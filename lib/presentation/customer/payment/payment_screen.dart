import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:ethiodrive_history/core/utils/user_messages.dart';
import 'package:ethiodrive_history/domain/models/app_settings.dart';
import 'package:ethiodrive_history/presentation/providers/app_providers.dart';
import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/app_card.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key, required this.chassisNumber});

  final String chassisNumber;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool _isProcessing = false;

  Future<void> _simulatePayment(AppSettings settings) async {
    final l10n = context.l10n;
    setState(() => _isProcessing = true);
    await Future<void>.delayed(const Duration(seconds: 2));

    final refNumber =
        'CHP-${DateFormat('yyyyMMdd').format(DateTime.now())}-${DateTime.now().millisecondsSinceEpoch % 100000}';

    try {
      await ref.read(registryRepositoryProvider).recordPayment(
            chassis: widget.chassisNumber,
            amountEtb: settings.paymentAmountEtb,
            reference: refNumber,
          );
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(UserMessages.fromError(e, l10n))),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isProcessing = false);
    context.go(
      '/report/${Uri.encodeComponent(widget.chassisNumber)}?ref=$refNumber',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final settingsAsync = ref.watch(settingsStreamProvider);
    final vehicleAsync = ref.watch(vehicleByChassisProvider(widget.chassisNumber));
    final currency = NumberFormat.currency(
      locale: locale,
      symbol: 'ETB ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.securePayment),
      ),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(l10n.errorLoadSettings('$e'))),
        data: (settings) {
          return vehicleAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
                Center(child: Text(l10n.errorGenericWithMessage('$e'))),
            data: (vehicle) => SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lock, color: AppColors.accentTeal),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.paymentChapaNotice,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.orderSummary,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(height: 16),
                          _SummaryRow(
                            label: l10n.vehicleLabel,
                            value: vehicle?.model ?? '—',
                          ),
                          _SummaryRow(
                            label: l10n.chassisSummaryLabel,
                            value: widget.chassisNumber,
                            mono: true,
                          ),
                          _SummaryRow(
                            label: l10n.reportTypeFull,
                            value: l10n.reportTypeFull,
                          ),
                          const Divider(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.total,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                currency.format(settings.paymentAmountEtb),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.accentTeal,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppCard(
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 48,
                            color:
                                AppColors.primaryOrange.withValues(alpha: 0.8),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.chapaGateway,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.paymentSimulateHint,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    GradientButton(
                      label: _isProcessing
                          ? l10n.processing
                          : l10n.payWithChapa,
                      icon: Icons.payment,
                      isLoading: _isProcessing,
                      onPressed: _isProcessing
                          ? null
                          : () => _simulatePayment(settings),
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
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.mono = false,
  });

  final String label;
  final String value;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: mono
                  ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      )
                  : Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
