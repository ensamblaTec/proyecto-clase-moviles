import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/models/task_model.dart';

class FilterTaskWidget extends StatefulWidget {
  const FilterTaskWidget({super.key});

  @override
  State<FilterTaskWidget> createState() => _FilterTaskWidgetState();
}

class _FilterTaskWidgetState extends State<FilterTaskWidget> {
  List<TaskModel> taskList = [
      TaskModel(idTask: 1, nameTask: 'T1', dscTask: '', sttTask: 'E'),
      TaskModel(idTask: 2, nameTask: 'T2', dscTask: '', sttTask: 'P'),
      TaskModel(idTask: 3, nameTask: 'T3', dscTask: '', sttTask: 'C'),
    ]; 
    List<TaskModel>? selectedUserList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openFilterDialog,
        child: const Icon(Icons.add),
      ),
      body: selectedUserList == null || selectedUserList!.isEmpty
          ? const Center(child: Text('No Task selected'))
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedUserList![index].nameTask!),
                );
              },
              itemCount: selectedUserList!.length,
            ),
    );
  }

    void openFilterDialog() async {
    await FilterListDialog.display<TaskModel>(
      context,
      listData: taskList,
      selectedListData: selectedUserList,
      choiceChipLabel: (task) => task!.nameTask,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (task, query) {
        return task.nameTask!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

   void openFilterDelegate() async {
   await FilterListDelegate.show<TaskModel>(
      context: context,
      list: taskList,
      onItemSearch: (task, query) {
        return task.nameTask!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (task) => task!.nameTask,
      emptySearchChild: Center(child: Text('No task found')),
      searchFieldHint: 'Search Here..',
      onApplyButtonClick: (list) {
        // Do something with selected list
      },
    );
  }
}