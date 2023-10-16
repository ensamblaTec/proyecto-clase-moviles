import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/add_task.dart';
import 'package:pmsn20232/screens/calendar_screen.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/detail_movie_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/provider_screen.dart';
import 'package:pmsn20232/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => DashboardScreen(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add': (BuildContext context) => const AddTask(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/popular': (BuildContext context) => const PopularScreen(),
    '/detail': (BuildContext context) => const DetailMovieScreen(),
    '/prov': (BuildContext context) => const ProviderScreen(),
    '/calendar': (BuildContext context) => const CalendarScreen(),
  };
}
