import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/screens/custom_list_movies_item.dart';
import 'package:flutter_application_base/screens/custom_list_movies_screen.dart';
import 'package:flutter_application_base/screens/estrenos_list_item.dart';
import 'package:flutter_application_base/screens/screens.dart';
import 'package:flutter_application_base/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _updateTheme() {
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Preferences.darkmode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        'home': (context) => const HomeScreen(),
        'estrenos_list_screen': (context) => const CustomListScreenEstrenos(),
        'estrenos_list_item': (context) => const EstrenosListItem(),
        'profile': (context) => ProfileScreen(onThemeChanged: _updateTheme),
        'actores': (context) => const ActoresListScreen(),
        'details': (context) => const ActorDetailScreen(),
        'record_list': (context) => const RecordListScreen(),
        'record_details': (context) => const RecordDetailsScreen(),
        'profile': (context) => ProfileScreen(onThemeChanged: _updateTheme),
        'custom_list_movies_screen': (context) => const CustomListMoviesScreen(),
        'custom_list_movies_item': (context) => const MovieDetailsScreen(),
        },
    );
  }
}
