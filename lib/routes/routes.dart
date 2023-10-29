import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/add/add_career.dart';
import 'package:pmsn20232/screens/add/add_task.dart';
import 'package:pmsn20232/screens/add/add_teacher.dart';
import 'package:pmsn20232/screens/calendar_screen.dart';
import 'package:pmsn20232/screens/career_screen.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/detail_movie_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/task_screen.dart';
import 'package:pmsn20232/screens/teacher_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/task': (BuildContext context) => TaskScreen(
          title: "Task Manager",
          dropDownValues: const [
            'Pendiente',
            'Completado',
            'En proceso',
            'Todo'
          ],
        ),
    '/teacher': (BuildContext context) => const TeacherScreen(
          title: "Teacher Manager",
        ),
    '/career': (BuildContext context) => const CareerScreen(
          title: "Career Manager",
        ),
    '/addCareer': (BuildContext context) => AddCareer(),
    '/add': (BuildContext context) => const AddTask(),
    '/addTeacher': (BuildContext context) => const AddTeacher(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/popular': (BuildContext context) => const PopularScreen(),
    '/detail': (BuildContext context) => const DetailMovieScreen(),
    '/calendar': (BuildContext context) => const CalendarScreen(),
  };
}
