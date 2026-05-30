import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';

import 'package:ethiodrive_history/core/theme/app_colors.dart';

import 'package:ethiodrive_history/domain/models/app_settings.dart';

import 'package:ethiodrive_history/presentation/providers/app_providers.dart';

import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';

import 'package:ethiodrive_history/presentation/shared/widgets/app_card.dart';

import 'package:ethiodrive_history/presentation/shared/widgets/language_switcher.dart';

import 'package:ethiodrive_history/presentation/shared/widgets/section_header.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';



class SettingsTab extends ConsumerStatefulWidget {

  const SettingsTab({super.key});



  @override

  ConsumerState<SettingsTab> createState() => _SettingsTabState();

}



class _SettingsTabState extends ConsumerState<SettingsTab> {

  final _amountController = TextEditingController();

  final _companyController = TextEditingController();

  final _footerController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  bool _initialized = false;

  bool _isSaving = false;



  @override

  void dispose() {

    _amountController.dispose();

    _companyController.dispose();

    _footerController.dispose();

    _emailController.dispose();

    _phoneController.dispose();

    super.dispose();

  }



  void _bindSettings(AppSettings settings) {

    if (_initialized) return;

    _amountController.text = settings.paymentAmountEtb.toStringAsFixed(0);

    _companyController.text = settings.companyName;

    _footerController.text = settings.pdfFooterText;

    _emailController.text = settings.supportEmail;

    _phoneController.text = settings.supportPhone;

    _initialized = true;

  }



  Future<void> _save(AppSettings current) async {

    final l10n = context.l10n;

    final amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text(l10n.invalidPaymentAmount)),

      );

      return;

    }



    setState(() => _isSaving = true);

    try {

      final updated = current.copyWith(

        paymentAmountEtb: amount,

        companyName: _companyController.text.trim(),

        pdfFooterText: _footerController.text.trim(),

        supportEmail: _emailController.text.trim(),

        supportPhone: _phoneController.text.trim(),

      );

      await ref.read(settingsRepositoryProvider).updateSettings(updated);

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text(l10n.settingsSaved)),

        );

      }

    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text(l10n.errorSaveFailed('$e'))),

        );

      }

    } finally {

      if (mounted) setState(() => _isSaving = false);

    }

  }



  @override

  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final settingsAsync = ref.watch(settingsStreamProvider);



    return settingsAsync.when(

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(child: Text(l10n.errorLoadSettings('$e'))),

      data: (settings) {

        _bindSettings(settings);

        return ListView(

          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),

          children: [

            const Padding(

              padding: EdgeInsets.only(bottom: 16),

              child: LanguageSwitcher(),

            ),

            AppCard(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  SectionHeader(title: l10n.systemSettings),

                  const SizedBox(height: 16),

                  _field(l10n.paymentAmountEtb, _amountController,

                      keyboardType: TextInputType.number),

                  _field(l10n.companyName, _companyController),

                  _field(l10n.pdfFooterText, _footerController, maxLines: 3),

                  _field(l10n.supportEmail, _emailController),

                  _field(l10n.supportPhone, _phoneController),

                  const SizedBox(height: 8),

                  Container(

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      color: AppColors.surfaceElevated,

                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: AppColors.border),

                    ),

                    child: Row(

                      children: [

                        const Icon(Icons.image_outlined,

                            color: AppColors.textMuted),

                        const SizedBox(width: 12),

                        Expanded(

                          child: Text(

                            l10n.logoUploadSoon,

                            style: GoogleFonts.inter(

                              fontSize: 12,

                              color: AppColors.textMuted,

                            ),

                          ),

                        ),

                      ],

                    ),

                  ),

                  const SizedBox(height: 20),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: _isSaving ? null : () => _save(settings),

                      child: _isSaving

                          ? const SizedBox(

                              width: 22,

                              height: 22,

                              child: CircularProgressIndicator(

                                strokeWidth: 2,

                                color: Colors.white,

                              ),

                            )

                          : Text(l10n.saveSettings),

                    ),

                  ),

                ],

              ),

            ),

          ],

        );

      },

    );

  }



  Widget _field(

    String label,

    TextEditingController controller, {

    TextInputType? keyboardType,

    int maxLines = 1,

  }) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 16),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(

            label.toUpperCase(),

            style: GoogleFonts.jetBrainsMono(

              fontSize: 10,

              letterSpacing: 1,

              color: AppColors.textMuted,

            ),

          ),

          const SizedBox(height: 6),

          TextField(

            controller: controller,

            keyboardType: keyboardType,

            maxLines: maxLines,

          ),

        ],

      ),

    );

  }

}


