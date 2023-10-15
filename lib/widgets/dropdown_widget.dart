import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  String? controller = '';
  DropDownWidget({super.key, this.controller});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {

    List<String> dropDownValues = ['Pendiente', 'Completado', 'En proceso'];
  String dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    dropDownValue = widget.controller!;
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        value: dropDownValue,
        dropdownColor: Colors.black87,
        icon: const Icon(Icons.info),
        decoration: InputDecoration(
          prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 14, right: 14),
                  child: const Icon(
                    Icons.info,
                  ),
                ),
                hintText: "Status",
                labelText: "Status"
        ),
        items: dropDownValues.map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
          value: value,
          child:Text(value),
          );
        }).toList(),
         onChanged: (String? newValue){
          dropDownValue=newValue!;
          widget.controller= newValue;
         },
        ),
    );
  }
}