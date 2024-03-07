import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale("en"),
        Locale("fr"),
        Locale("sw"),
      ],
      debugShowCheckedModeBanner: false,
      title: 'DHIS2 SDK Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
