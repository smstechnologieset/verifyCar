import 'package:ethiodrive_history/core/extensions/l10n_extension.dart';

import 'package:ethiodrive_history/core/theme/app_colors.dart';

import 'package:ethiodrive_history/core/utils/user_messages.dart';

import 'package:ethiodrive_history/presentation/providers/repository_providers.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';



class AdminLoginScreen extends ConsumerStatefulWidget {

  const AdminLoginScreen({super.key});



  @override

  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();

}



class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  bool _isLoading = false;

  String? _loginError;



  @override

  void dispose() {

    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();

  }



  Future<void> _login() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {

      _isLoading = true;

      _loginError = null;

    });



    final l10n = context.l10n;



    try {

      await ref.read(authRepositoryProvider).signInAdmin(

            email: _emailController.text.trim(),

            password: _passwordController.text,

          );

      if (!mounted) return;

      context.go('/admin/dashboard');

    } on FirebaseAuthException catch (e) {

      if (!mounted) return;

      setState(() => _loginError = UserMessages.authError(e, l10n));

    } catch (e) {

      if (!mounted) return;

      setState(() => _loginError = UserMessages.fromError(e, l10n));

    } finally {

      if (mounted) setState(() => _isLoading = false);

    }

  }



  @override

  Widget build(BuildContext context) {

    final l10n = context.l10n;



    return SafeArea(

      child: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Container(

            constraints: const BoxConstraints(maxWidth: 420),

            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(

              color: AppColors.surface,

              borderRadius: BorderRadius.circular(20),

              border: Border.all(color: AppColors.border),

            ),

            child: Form(

              key: _formKey,

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Container(

                    width: 64,

                    height: 64,

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      color: AppColors.primaryOrange.withValues(alpha: 0.15),

                    ),

                    child: const Icon(

                      Icons.vpn_key,

                      color: AppColors.primaryOrange,

                      size: 28,

                    ),

                  ),

                  const SizedBox(height: 20),

                  Text(

                    l10n.adminSignIn,

                    style: GoogleFonts.inter(

                      fontSize: 18,

                      fontWeight: FontWeight.w700,

                      letterSpacing: 0.5,

                    ),

                  ),

                  const SizedBox(height: 8),

                  Text(

                    l10n.adminSignInSubtitle,

                    textAlign: TextAlign.center,

                    style: GoogleFonts.inter(

                      fontSize: 13,

                      color: AppColors.textMuted,

                    ),

                  ),

                  const SizedBox(height: 28),

                  Align(

                    alignment: Alignment.centerLeft,

                    child: Text(

                      l10n.adminEmail,

                      style: GoogleFonts.jetBrainsMono(

                        fontSize: 11,

                        letterSpacing: 1.2,

                        color: AppColors.textMuted,

                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: _emailController,

                    keyboardType: TextInputType.emailAddress,

                    autocorrect: false,

                    style: GoogleFonts.jetBrainsMono(fontSize: 14),

                    decoration: InputDecoration(

                      hintText: l10n.adminEmailHint,

                    ),

                    validator: (v) {

                      if (v == null || v.trim().isEmpty) {

                        return l10n.emailRequired;

                      }

                      if (!v.contains('@')) return l10n.emailInvalid;

                      return null;

                    },

                  ),

                  const SizedBox(height: 20),

                  Align(

                    alignment: Alignment.centerLeft,

                    child: Text(

                      l10n.password,

                      style: GoogleFonts.jetBrainsMono(

                        fontSize: 11,

                        letterSpacing: 1.2,

                        color: AppColors.textMuted,

                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: _passwordController,

                    obscureText: _obscurePassword,

                    style: GoogleFonts.jetBrainsMono(fontSize: 14),

                    decoration: InputDecoration(

                      hintText: '••••••••',

                      suffixIcon: IconButton(

                        icon: Icon(

                          _obscurePassword

                              ? Icons.visibility_off

                              : Icons.visibility,

                          color: AppColors.textMuted,

                        ),

                        onPressed: () => setState(

                          () => _obscurePassword = !_obscurePassword,

                        ),

                      ),

                    ),

                    validator: (v) {

                      if (v == null || v.isEmpty) {

                        return l10n.passwordRequired;

                      }

                      return null;

                    },

                  ),

                  if (_loginError != null) ...[

                    const SizedBox(height: 16),

                    Container(

                      width: double.infinity,

                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(

                        color: AppColors.destructive.withValues(alpha: 0.08),

                        borderRadius: BorderRadius.circular(10),

                        border: Border.all(

                          color: AppColors.destructive.withValues(alpha: 0.35),

                        ),

                      ),

                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Icon(

                            Icons.error_outline,

                            color: AppColors.destructive,

                            size: 20,

                          ),

                          const SizedBox(width: 8),

                          Expanded(

                            child: Text(

                              _loginError!,

                              style: GoogleFonts.inter(

                                fontSize: 13,

                                color: AppColors.destructive,

                                height: 1.4,

                              ),

                            ),

                          ),

                        ],

                      ),

                    ),

                  ],

                  const SizedBox(height: 28),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: _isLoading ? null : _login,

                      child: _isLoading

                          ? const SizedBox(

                              width: 22,

                              height: 22,

                              child: CircularProgressIndicator(

                                strokeWidth: 2,

                                color: Colors.white,

                              ),

                            )

                          : Text(l10n.signInDashboard),

                    ),

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}


