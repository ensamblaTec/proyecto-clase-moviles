import 'package:flutter/material.dart';

class TeacherProvider with ChangeNotifier {
  bool _isUpdated = false;

  bool get teacherProvider {
    return _isUpdated;
  }

  set isUpdated(bool value) {
    _isUpdated = value;
    notifyListeners();
    // _isUpdated = false;
  }
}