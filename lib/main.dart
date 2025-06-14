import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/screens/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(LocalUserAdapter());

  final localUserBox = await Hive.openBox<LocalUser>('localUserBox');

  // Initialize with default LocalUser if it's empty
  if (localUserBox.isEmpty) {
    await localUserBox.put('user', LocalUser(favorites: [], watchLater: []));
  }

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(create: (_) => LocalUserProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 20, 20, 20),
          onSurface: Colors.white,
          secondary: const Color.fromARGB(255, 30, 30, 30),
          primary: const Color.fromARGB(255, 230, 170, 27),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 230, 170, 27),
            foregroundColor: const Color.fromARGB(255, 47, 47, 47),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            disabledBackgroundColor: const Color.fromARGB(255, 81, 81, 81),
            disabledForegroundColor: const Color.fromARGB(100, 255, 255, 255),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color.fromARGB(255, 18, 18, 18),
          labelStyle: TextStyle(color: Colors.white),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: routes,
    );
  }
}
