import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/styles.dart';
import 'package:pmsn20232/provider/test_provider.dart';
import 'package:pmsn20232/routes/routes.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/services/local_storage.dart';
import 'package:pmsn20232/services/tasks_provider.dart';
import 'package:pmsn20232/services/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isActive = false;

  @override
  void initState() {
    if (LocalStorage.prefs.getBool('isActiveSession') != null) {
      LocalStorage.prefs.getBool('isActiveSession') as bool == true
          ? isActive = true
          : isActive = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => TestProvider())
        ],
        child: Consumer<ThemeProvider>(builder: (context, model, child) {
          final changeTheme = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: getRoutes(),
            theme: !changeTheme.isLightTheme
                ? StylesApp.lightTheme(context)
                : StylesApp.darkTheme(context),
            home: isActive ? const DashboardScreen() : const LoginScreen(),
          );
        }));
  }
}
