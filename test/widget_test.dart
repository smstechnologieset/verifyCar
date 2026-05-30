import 'package:ethiodrive_history/app.dart';
import 'package:ethiodrive_history/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads with localization', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en'), Locale('am')],
          locale: Locale('am'),
          home: EthioDriveApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(EthioDriveApp), findsOneWidget);
  });
}
