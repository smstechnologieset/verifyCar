import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:ethiodrive_history/presentation/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final l10n = context.l10n;
    final isAm = locale.languageCode == 'am';

    if (compact) {
      return SegmentedButton<bool>(
        segments: [
          ButtonSegment(
            value: false,
            label: Text(l10n.languageEnglish, style: const TextStyle(fontSize: 11)),
          ),
          ButtonSegment(
            value: true,
            label: Text(l10n.languageAmharic, style: const TextStyle(fontSize: 11)),
          ),
        ],
        selected: {isAm},
        onSelectionChanged: (selected) {
          ref.read(localeProvider.notifier).state =
              Locale(selected.first ? 'am' : 'en');
        },
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, size: 18, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(
            l10n.languageLabel,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 8),
          _LangChip(
            label: l10n.languageEnglish,
            selected: !isAm,
            onTap: () =>
                ref.read(localeProvider.notifier).state = const Locale('en'),
          ),
          const SizedBox(width: 4),
          _LangChip(
            label: l10n.languageAmharic,
            selected: isAm,
            onTap: () =>
                ref.read(localeProvider.notifier).state = const Locale('am'),
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.govNavy : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
