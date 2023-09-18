import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController txtConName = TextEditingController();
    final txtNameTask = TextField(
      controller: txtConName,
    );
    final TextEditingController txtConDesc = TextEditingController();
    final txtDescTask = TextField(
      controller: txtConName,
    );
    List<String> dropDownValues = <String>[
      "Pendiente",
      "En proceso",
      "Completado",
    ];
    String dropDownValue = dropDownValues.first;
    DropdownButton statusTask = DropdownButton(
      items: , 
      onChanged: (value) {
        
      }, 
    );
    return Container();
  }
}