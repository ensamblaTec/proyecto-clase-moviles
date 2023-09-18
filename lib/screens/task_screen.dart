import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.task)
          )
        ],
      ),
      body: FutureBuilder(
        future: AgendaDB.GetAllTask(),
        builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: 5,
                // snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return Text('data $index chachaChau!');
                }
              );
          }
          if(snapshot.hasError){
            return const Center(
              child: Text('Error'),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}