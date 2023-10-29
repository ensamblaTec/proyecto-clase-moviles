import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AgendaDB {
  static const nameDB = 'AGENDADB';
  static const versionDB = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String queryTareas = '''CREATE TABLE tblTareas( 
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask VARCHAR(1),
      initDate DATETIME,
      endDate DATETIME
    );''';
    String queryCareer = '''CREATE TABLE tblCareer( 
      idCareer INTEGER PRIMARY KEY,
      career VARCHAR(50)
    );''';
    String queryTeacher = '''CREATE TABLE tblTeacher(
      idTeacher INTEGER PRIMARY KEY,
      name VARCHAR(50),
      email VARCHAR(100),
      idCareer INTEGER,
      FOREIGN KEY(idCareer) REFERENCES tblCareer(idCareer)
    );''';
    db.execute(queryCareer);
    db.execute(queryTeacher);
    db.execute(queryTareas);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> updateStatusCompleted(
      String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByStatus(String status) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: [status]);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByText(String nameTask) async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas',
        where: "nameTask LIKE ?", whereArgs: ['%$nameTask%']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }
}
