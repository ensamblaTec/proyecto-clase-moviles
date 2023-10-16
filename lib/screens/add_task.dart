import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/services/tasks_provider.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime initSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();
final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != endSelectedDate) {
      setState(() {
        print(endSelectedDate.toString().substring(0,19));
        endSelectedDate = picked;
      });
    }
  }

  Future<void> _selectDateInit(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != initSelectedDate) {
      setState(() {
        initSelectedDate = picked;
      });
    }
  }

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
    dropDownWidget = DropDownWidget(controller: value, values: const <String>['Pendiente', 'En proceso', 'Completado'],);
  }

  @override
  Widget build(BuildContext context) {

    final taskProvider = Provider.of<TaskProvider>(context);
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      verifyIsEditting(data);
    } else {
      dropDownWidget = DropDownWidget(controller: 'Pendiente', values: const <String>['Pendiente', 'En proceso', 'Completado'],);
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
                  'initDate': initSelectedDate.toString().substring(0,19),
                  'endDate': endSelectedDate.toString().substring(0,19),
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
'initDate': initSelectedDate.toString().substring(0,19),
                  'endDate': endSelectedDate.toString().substring(0,19),
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
            buildDateInitSelector(context, "Fecha Inicial"),
            buildDateEndSelector(context, "Fecha Final"),
            btnGuardar,
          ],
        ),
      ),
    );
  }
  
  Widget buildDateEndSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text:
              dateFormat.format(endSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateEnd(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }
  
  Widget buildDateInitSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text:
              dateFormat.format(initSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateInit(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }
}
