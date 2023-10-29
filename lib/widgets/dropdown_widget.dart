import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatelessWidget {
  DropDownWidget({
    super.key,
    this.controller = "",
    this.values = const [""],
    this.labelText = "",
  });
  String labelText;
  String? controller;
  int? id = -1;
  List<String>? values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        value: controller,
        icon: const Icon(Icons.info),
        decoration: InputDecoration(
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 14, right: 14),
              child: const Icon(
                Icons.info,
              ),
            ),
            hintText: labelText,
            labelText: labelText),
        items: values!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller = newValue;
          id = values!.indexOf(newValue!);
        },
      ),
    );
  }
}
