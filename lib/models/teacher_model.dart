class TeacherModel {
  int? idTeacher;
  int? idCarrera;
  String? nameTeacher;
  String? email
  

  TeacherModel({this.idTeacher, this.nameTeacher, this.email, this.idCarrera});

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
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
