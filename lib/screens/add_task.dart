import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';

class AddTask extends StatefulWidget {
  final TaskModel? taskModel;
  const AddTask({super.key, this.taskModel});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  
    TextEditingController txtConName = TextEditingController();
    TextEditingController txtConDsc = TextEditingController();
    String dropDownValue = "Pendiente";
    List<String> dropDownValues = [
      'Pendiente',
      'Completado',
      'En proceso'
    ];

AgendaDB? agendaDB;
@override
void initState( ) {

  super.initState();
  agendaDB = AgendaDB();
}

  @override
  Widget build(BuildContext context) {

    
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
        label: Text('Task Name'),
        border: OutlineInputBorder()
      ),
      controller: txtConName,
    );

    final txtDscTask = TextFormField(
      decoration: const InputDecoration(
        label: Text('Task Description'),
        border: OutlineInputBorder()
      ),
      controller: txtConDsc,
    );

    const space = SizedBox(height: 10,);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(), 
      onChanged: (value) {
        dropDownValue = value;
        setState(() { });
      }
    );

    final ElevatedButton btnGuardar = ElevatedButton(onPressed: () {
      agendaDB!.INSERT('tblTareas', {
        'nameTask': txtConName.text,
        'dscTask' : txtConDsc.text,
        'sttTask' : dropDownValue.substring(1,1),
      }).then((value) {
        var snackBar = SnackBar(
          content: Text(value > 0 ? 'La inserción se ha completado' : 'La inserción ha fallado'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      });
    }, child: const Text('Save Task'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
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
            ddBStatus,
            space,
            btnGuardar,
          ],
        ),
      ),
    );
  }
}