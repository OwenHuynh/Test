import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'pump_widget_wrapper.dart';

void main() {
  test('Localy', () async {
    expect(Localy, isNotNull);
  });

  testWidgets('L10n', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          return Text(
            Localy.of(context)!.commonOk,
            textDirection: TextDirection.ltr,
          );
        }),
        locale: const Locale.fromSubtags(languageCode: 'ja'),
        localizationsDelegates: const [
          Localy.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja', ''),
          Locale('en', ''),
        ],
      ),
    );
    expect(find.byType(Text), findsOneWidget);
    expect(find.textContaining('Ok'), findsOneWidget);
  });

  testWidgets('testAppInjector', (WidgetTester tester) async {
    await tester.pumpWidget(
      testAppInjector(
        Builder(builder: (context) {
          return Text(Localy.of(context)!.commonOk);
        }),
      ),
    );

    expect(find.textContaining('Ok'), findsOneWidget);
  });
}
