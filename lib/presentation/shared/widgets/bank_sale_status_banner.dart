import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankSaleStatusBanner extends StatelessWidget {
  const BankSaleStatusBanner({super.key, required this.blockedByBankForSale});

  final bool blockedByBankForSale;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final blocked = blockedByBankForSale;
    final color = blocked ? AppColors.destructive : AppColors.accentTeal;
    final background = blocked
        ? AppColors.destructive.withValues(alpha: 0.12)
        : AppColors.accentTeal.withValues(alpha: 0.12);
    final border = blocked
        ? AppColors.destructive.withValues(alpha: 0.4)
        : AppColors.accentTeal.withValues(alpha: 0.4);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(
            blocked ? Icons.block : Icons.verified,
            color: color,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.bankSaleStatus,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    letterSpacing: 1.2,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blocked ? l10n.blockedByBank : l10n.notBlockedByBank,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
