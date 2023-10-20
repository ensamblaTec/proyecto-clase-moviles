import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/teacher_model.dart';
import 'package:pmsn20232/services/teacher_provider.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  TeacherModel? args;
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  DropDownWidget? dropDownWidget;
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  void verifyIsEditting(data) {
    String stt;
    if (data == null) {
      args = null;
      return;
    }

    args = data as TeacherModel;
    txtConName.text =
        !txtConName.text.isNotEmpty ? args!.nameTeacher! : txtConName.text;
    txtConEmail.text =
        !txtConEmail.text.isNotEmpty ? args!.email! : txtConEmail.text;
    stt = args!.idCarrera! as String;
    var value = '';
    switch (stt) {
      case 'E':
        value = 'En proceso';
        break;
      case 'C':
        value = 'Completado';
        break;
      case 'P':
        value = 'Pendiente';
        break;
      default:
        value = 'Pendiente';
    }
    dropDownWidget = DropDownWidget(
      controller: value,
      values: const <String>['Pendiente', 'En proceso', 'Completado'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      verifyIsEditting(data);
    } else {
      dropDownWidget = DropDownWidget(
        controller: 'Pendiente',
        values: const <String>['Pendiente', 'En proceso', 'Completado'],
      );
    }

    final txtNameTeacher = TextFormField(
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        label: Text('Teacher Name'),
        border: OutlineInputBorder(),
      ),
      controller: txtConName,
    );

    final txtEmailTeacher = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email'), border: OutlineInputBorder()),
      controller: txtConEmail,
    );

    const space = SizedBox(
      height: 10,
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          args == null
              ? agendaDB!.INSERT('teacher', {
                  'teacher': txtConName.text,
                  'email': txtConEmail.text,
                  'idCarrera': dropDownWidget!.id!,
                }).then((value) {
                  var snackBar = SnackBar(
                    content: Text(value > 0
                        ? 'La Inserción se ha completado'
                        : 'La Inserción ha fallado'),
                    showCloseIcon: true,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  teacherProvider.isUpdated = true;
                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  teacherProvider.notifyListeners();
                  Navigator.pop(context);
                })
              : agendaDB!.UPDATE('teacher', {
                  'idTeacher': args!.idTeacher,
                  'teacher': txtConName.text,
                  'email': txtConEmail.text,
                  'idCareer': dropDownWidget!.id!,
                }).then((value) {
                  var snackBar = SnackBar(
                    content: Text(value > 0
                        ? 'La Actualización se ha completado'
                        : 'La Actualización ha fallado'),
                    showCloseIcon: true,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  teacherProvider.isUpdated = true;
                  Navigator.pop(context);
                });
        },
        child: const Text('Save Teacher'));
    return Scaffold(
      appBar: AppBar(
        title: args == null
            ? const Text('Add Teacher')
            : const Text('Update Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtNameTeacher,
            space,
            txtEmailTeacher,
            space,
            dropDownWidget!,
            space,
            btnGuardar,
          ],
        ),
      ),
    );
  }
}
