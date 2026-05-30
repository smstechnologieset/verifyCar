import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:ethiodrive_history/presentation/providers/app_providers.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/app_card.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VehiclePreviewScreen extends ConsumerWidget {
  const VehiclePreviewScreen({super.key, required this.chassisNumber});

  final String chassisNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vehicleAsync = ref.watch(vehicleByChassisProvider(chassisNumber));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.vehicleFound),
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorGenericWithMessage('$e'))),
        data: (vehicle) {
          if (vehicle == null) {
            return Center(child: Text(l10n.vehicleNotFoundShort));
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color:
                                AppColors.accentTeal.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            color: AppColors.accentTeal,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _PreviewLine(
                          label: l10n.modelLabel,
                          value: vehicle.model,
                        ),
                        const SizedBox(height: 12),
                        _PreviewLine(
                          label: l10n.colorLabel,
                          value: vehicle.color,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.confirmVehicleQuestion,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const Spacer(),
                  GradientButton(
                    label: l10n.viewFullDetails,
                    icon: Icons.lock_open,
                    onPressed: () => context.push(
                      '/payment/${Uri.encodeComponent(chassisNumber)}',
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    child: Text(l10n.cancel),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textMuted,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
