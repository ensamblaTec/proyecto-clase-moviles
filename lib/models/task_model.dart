class TaskModel {
  int? idTask;
  String? nameTask;
  String? dscTask;
  String? sttTask;
  DateTime? dateTask;

  TaskModel({this.sttTask, this.idTask, this.nameTask, this.dscTask, this.dateTask});
  
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        idTask: map['idTask'],
        dscTask: map['dscTask'],
        nameTask: map['nameTask'],
        sttTask: map['sttTask'],
        dateTask: map['dateTask'],
        );
  }

  Map<String, dynamic> getValuesMap() {
    return {
      'idTask': idTask,
      'nameTask': nameTask,
      'dscTask': dscTask,
      'sttTask': sttTask,
      'dateTask': dateTask,
    };
  }
}
