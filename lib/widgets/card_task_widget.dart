import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/screens/add_task.dart';

// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  AgendaDB agendaDB;
  TaskModel taskModel;
  CardTaskWidget(this.agendaDB, {super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            children: [
              Text(taskModel.nameTask!),
              Text(taskModel.dscTask!),
            ],
          ),
          const Expanded(
            child: Text(''),
          ),
          Column(
            children: [
              IconButton(onPressed: () {
                Navigator.pushNamed(context, '/add', arguments: {'taskModel': taskModel});
              }, icon: const Icon(Icons.update)), 
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Confirm to delete"),
                          icon: const Icon(Icons.dangerous),
                          content: const Text('Do you want delete task?'),
                          alignment: Alignment.center,
                          actions: [
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                                child: const Text('Confirm'),
                                onPressed: () => agendaDB
                                        .DELETE("tblTareas", taskModel.idTask!)
                                        .then((value) {
                                      Navigator.pop(context);
                                    })),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
