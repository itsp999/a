import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppLanguage(),
      child: const ProjectAApp(),
    ),
  );
}

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('zh');

  Locale get appLocale => _appLocale;

  void changeLanguage(Locale type) async {
    if (_appLocale == type) return;
    _appLocale = type;
    notifyListeners();
  }
}

class ProjectAApp extends StatelessWidget {
  const ProjectAApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguage>(context);
    return MaterialApp(
      title: 'Project A E-commerce',
      locale: languageProvider.appLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('zh', ''), // Chinese
        Locale('es', ''), // Spanish
        Locale('fr', ''), // French
      ],
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project A'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Language Switching Logic
              showModalBottomSheet(
                context: context,
                builder: (context) => const LanguagePicker(),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text('Home Screen')),
    );
  }
}

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguage>(context, listen: false);
    return Wrap(
      children: [
        ListTile(title: const Text('English'), onTap: () => languageProvider.changeLanguage(const Locale('en'))),
        ListTile(title: const Text('中文'), onTap: () => languageProvider.changeLanguage(const Locale('zh'))),
        ListTile(title: const Text('Español'), onTap: () => languageProvider.changeLanguage(const Locale('es'))),
      ],
    );
  }
}
