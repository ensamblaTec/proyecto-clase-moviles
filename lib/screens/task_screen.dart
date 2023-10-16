import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/services/tasks_provider.dart';
import 'package:pmsn20232/widgets/card_task_widget.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;
  List<TaskModel> taskList = [
      TaskModel(idTask: 1, nameTask: 'T1', dscTask: '', sttTask: 'E'),
      TaskModel(idTask: 1, nameTask: 'T5', dscTask: '', sttTask: 'E'),
      TaskModel(idTask: 1, nameTask: 'T9', dscTask: '', sttTask: 'E'),
      TaskModel(idTask: 2, nameTask: 'T2', dscTask: '', sttTask: 'P'),
      TaskModel(idTask: 3, nameTask: 'T3', dscTask: '', sttTask: 'C'),
    ]; 
    List<TaskModel>? selectedUserList = [];
    List<String>? selectedTaskList = [];
    List<String> dropDownValues = [];
    DropDownWidget? dropDownFilter;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    dropDownValues = ['Pendiente', 'Completado', 'En proceso', 'Todo'];
    dropDownFilter = DropDownWidget(controller: 'Todo', values: dropDownValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add')
                      .then((value) => {setState(() {})});
                },
                icon: const Icon(Icons.task))
          ],
        ),
        body: Stack(
          children: [futureBuilder()],
          // children: [filtered(context)],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () => openFilterDialog(context),
        child: const Icon(Icons.add),
      ),);
  }

  void openFilterDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Filter"),
        content: const Text("Choose option"),
        actions: [
          dropDownFilter!,
          ElevatedButton(onPressed: () => setState(() {
          }), child: const Text("OK"))
          
        ],

      )
    );
  }

  FutureBuilder<List<TaskModel>> futureBuilder() {
    final updateTask = Provider.of<TaskProvider>(context);
    if (updateTask.isUpdated) {
    return filterDataGetting(updateTask);
    }
    return filterDataGetting(updateTask);
  }

  FutureBuilder<List<TaskModel>> filterDataGetting(TaskProvider updateTask) {
    print("Hola ${dropDownFilter!.controller}");
    switch(dropDownFilter!.controller) {
      case 'En proceso':
        return gettingByStatus(updateTask, 'E');
      case 'Completado':
        return gettingByStatus(updateTask, 'C');
      case 'Pendiente':
        return gettingByStatus(updateTask, 'P');
      default:
        return FutureBuilder(
      future: agendaDB!.GETALLTASK(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (updateTask.isUpdated) {
          return getList(snapshot);
        } else {
          return getList(snapshot);
        }
      });
    }
  }

  FutureBuilder<List<TaskModel>> gettingByStatus(TaskProvider updateTask, String status) {
    return FutureBuilder(
    future: agendaDB!.getTaskByStatus(status),
    builder:
        (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
      if (updateTask.isUpdated) {
        return getList(snapshot);
      } else {
        return getList(snapshot);
      }
    });
  }

  Widget getList(snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data!.length, //snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return CardTaskWidget(
              agendaDB!,
              taskModel: snapshot.data![index],
            );
          });
    } else {
      if (snapshot.hasError) {
        return const Center(
          child: Text('Error!'),
        );
      } else {
        return const CircularProgressIndicator();
      }
    }
  }
}
