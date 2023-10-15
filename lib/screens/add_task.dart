import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/services/tasks_provider.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TaskModel? args;
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
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
    args = data as TaskModel;
    txtConName.text =
        !txtConName.text.isNotEmpty ? args!.nameTask! : txtConName.text;
    txtConDsc.text =
        !txtConDsc.text.isNotEmpty ? args!.dscTask! : txtConDsc.text;
    stt = args!.sttTask!.substring(0, 1);

    switch (stt) {
      case 'E':
        dropDownWidget = DropDownWidget(controller: "En proceso",);
        break;
      case 'C':
        dropDownWidget = DropDownWidget(controller: "Completado",);
        break;
      case 'P':
        dropDownWidget = DropDownWidget(controller: 'Pendiente',);
        break;
      default:
        dropDownWidget = DropDownWidget(controller: 'Pendiente',);
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      verifyIsEditting(data);
    } else {
      dropDownWidget = DropDownWidget(controller: 'Pendiente',);
    }

    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Task Name'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Task Description'), border: OutlineInputBorder()),
      controller: txtConDsc,
    );

    const space = SizedBox(
      height: 10,
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          args == null
              ? agendaDB!.INSERT('tblTareas', {
                  'nameTask': txtConName.text,
                  'dscTask': txtConDsc.text,
                  'sttTask': dropDownWidget!.controller!.substring(0, 1),
                }).then((value) {
                  var snackBar = SnackBar(
                    content: Text(value > 0
                        ? 'La Inserción se ha completado'
                        : 'La Inserción ha fallado'),
                    showCloseIcon: true,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  taskProvider.isUpdated = true;
                  taskProvider.notifyListeners();
                  Navigator.pop(context);
                })
              : agendaDB!.UPDATE('tblTareas', {
                  'idTask': args!.idTask,
                  'nameTask': txtConName.text,
                  'dscTask': txtConDsc.text,
                  'sttTask': dropDownWidget!.controller!.substring(0, 1),
                }).then((value) {
                  var snackBar = SnackBar(
                    content: Text(value > 0
                        ? 'La Actualización se ha completado'
                        : 'La Actualización ha fallado'),
                    showCloseIcon: true,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  taskProvider.isUpdated = true;
                  Navigator.pop(context);
                });
        },
        child: const Text('Save Task'));

    return Scaffold(
      appBar: AppBar(
        title:
            args == null ? const Text('Add task') : const Text('Update task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtNameTask,
            space,
            txtDscTask,
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
