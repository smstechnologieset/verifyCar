import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';
import 'package:ethiodrive_history/core/theme/app_colors.dart';
import 'package:ethiodrive_history/core/utils/user_messages.dart';
import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/gradient_button.dart';
import 'package:ethiodrive_history/presentation/shared/widgets/language_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _chassisController = TextEditingController();
  bool _isSearching = false;
  String? _searchError;

  @override
  void dispose() {
    _chassisController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSearching = true;
      _searchError = null;
    });

    final l10n = context.l10n;
    final chassis = _chassisController.text.trim();
    try {
      final vehicle =
          await ref.read(vehicleRepositoryProvider).findByChassis(chassis);

      try {
        await ref.read(registryRepositoryProvider).logSearch(
              chassis: chassis,
              found: vehicle != null,
            );
      } catch (_) {
        // Analytics failure should not block the customer search flow.
      }

      if (!mounted) return;
      setState(() => _isSearching = false);

      if (vehicle == null) {
        setState(() => _searchError = UserMessages.vehicleNotFound(l10n));
        return;
      }

      context.push('/preview/${Uri.encodeComponent(chassis)}');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSearching = false;
        _searchError = UserMessages.fromError(e, l10n);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _MinistryHeaderBand(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _BrandHeader(),
                      const SizedBox(height: 24),
                      _SearchCard(
                        chassisController: _chassisController,
                        isSearching: _isSearching,
                        searchError: _searchError,
                        onSearch: _search,
                        onChassisChanged: () {
                          if (_searchError != null) {
                            setState(() => _searchError = null);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      const _HowItWorksSection(),
                      const SizedBox(height: 16),
                      const _TrustInfoSection(),
                    ],
                  ),
                ),
              ),
            ),
            const _HomeFooter(),
          ],
        ),
      ),
    );
  }
}

class _MinistryHeaderBand extends StatelessWidget {
  const _MinistryHeaderBand();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.govNavy,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.ministryOfTransport,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                ),
                Text(
                  l10n.federalRegistrySubtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                ),
              ],
            ),
          ),
          const LanguageSwitcher(compact: true),
        ],
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            border: Border.all(color: AppColors.govNavy, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.govNavy.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.verified_user,
            size: 40,
            color: AppColors.govNavy,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.homeHeadline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.homeSubtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.chassisController,
    required this.isSearching,
    required this.onSearch,
    this.searchError,
    this.onChassisChanged,
  });

  final TextEditingController chassisController;
  final bool isSearching;
  final VoidCallback onSearch;
  final String? searchError;
  final VoidCallback? onChassisChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.search, color: AppColors.govNavy, size: 22),
              const SizedBox(width: 8),
              Text(
                l10n.vehicleLookup,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.govNavy,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.chassisLabel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: chassisController,
            onChanged: (_) => onChassisChanged?.call(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: l10n.chassisHint,
              prefixIcon: const Icon(Icons.pin_outlined, color: AppColors.textMuted),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.chassisRequired;
              }
              if (value.trim().length < 8) {
                return l10n.chassisTooShort;
              }
              return null;
            },
          ),
          if (searchError != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.destructive.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.destructive.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 20,
                    color: AppColors.destructive,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      searchError!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.destructive,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          GradientButton(
            label: isSearching ? l10n.searchingRegistry : l10n.searchRegistry,
            icon: Icons.arrow_forward,
            isLoading: isSearching,
            onPressed: isSearching ? null : onSearch,
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.howVerificationWorks,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.govNavy,
              ),
        ),
        const SizedBox(height: 12),
        _StepTile(
          step: '1',
          title: l10n.step1Title,
          subtitle: l10n.step1Subtitle,
          icon: Icons.edit_document,
        ),
        _StepTile(
          step: '2',
          title: l10n.step2Title,
          subtitle: l10n.step2Subtitle,
          icon: Icons.fact_check_outlined,
        ),
        _StepTile(
          step: '3',
          title: l10n.step3Title,
          subtitle: l10n.step3Subtitle,
          icon: Icons.lock_outline,
        ),
        _StepTile(
          step: '4',
          title: l10n.step4Title,
          subtitle: l10n.step4Subtitle,
          icon: Icons.description_outlined,
          isLast: true,
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isLast = false,
  });

  final String step;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.govNavy.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                step,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.govNavy,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            Icon(icon, color: AppColors.accentTeal, size: 22),
          ],
        ),
      ),
    );
  }
}

class _TrustInfoSection extends StatelessWidget {
  const _TrustInfoSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warningSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.govGold.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.security, color: AppColors.govGold, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.trustTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.govNavy,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.trustBody,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.45,
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

class _HomeFooter extends StatelessWidget {
  const _HomeFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Text(
        context.l10n.homeFooter,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.4,
            ),
      ),
    );
  }
}
