import 'package:ethiodrive_history/core/router/app_router.dart';
import 'package:ethiodrive_history/core/theme/app_theme.dart';
import 'package:ethiodrive_history/l10n/app_localizations.dart';
import 'package:ethiodrive_history/presentation/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EthioDriveApp extends ConsumerWidget {
  const EthioDriveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'EthioDrive History',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightForLocale(locale),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
