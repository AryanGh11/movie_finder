import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/theme.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_finder/models/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/firebase_options.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(LocalUserAdapter());
  Hive.registerAdapter(CastAdapter());

  final localUserBox = await Hive.openBox<LocalUser>('localUserBox');

  // Initialize with default LocalUser if it's empty
  if (localUserBox.isEmpty) {
    await localUserBox.put(
      'user',
      LocalUser(favorites: [], watchLater: [], appLang: "en"),
    );
  }

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    Phoenix(
      child: ChangeNotifierProvider(
        create: (_) => LocalUserProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localUserProvider = Provider.of<LocalUserProvider>(context);

    return MaterialApp(
      title: 'Movie Finder',
      locale: Locale(localUserProvider.appLang),
      supportedLocales: const [Locale("en"), Locale("fa")],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      routes: routes,
    );
  }
}
