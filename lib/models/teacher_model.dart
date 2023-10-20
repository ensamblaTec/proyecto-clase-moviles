class TaskModel {
  int? idTeacher;
  int? idCarrera;
  String? nameTeacher;
  String? email;

  TaskModel({this.idTeacher, this.nameTeacher, this.email, this.idCarrera});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      idTeacher: map['idTeacher'],
      nameTeacher: map['nameTeacher'],
      idCarrera: map['idCarrera'],
      email: map['email'],
    );
  }

  Map<String, dynamic> getValuesMap() {
    return {
      'idTeacher': idTeacher,
      'nameTeacher': nameTeacher,
      'idCarrera': idCarrera,
      'email': email,
    };
  }
}
