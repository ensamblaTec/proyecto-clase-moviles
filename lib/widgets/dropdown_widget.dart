import 'package:flutter/material.dart';

class DownListGender extends StatefulWidget {
  String? controller = "Completado";
  DownListGender({super.key, this.controller});

  @override
  State<DownListGender> createState() => _DownListGenderState();
}

class _DownListGenderState extends State<DownListGender> {

    List<String> dropDownValues = ['Pendiente', 'Completado', 'En proceso'];
  String dropdownValue = 'Pendiente';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        dropdownColor: Colors.black87,
        icon: const Icon(Icons.expand_more),
        decoration: InputDecoration(
          prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 14, right: 14),
                  child: const Icon(
                    Icons.man,
                  ),
                ),
                hintText: "Genero",
                labelText: "Genero"
        ),
        items: dropDownValues.map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
          value: value,
          child:Text(value),
          );
        }).toList(),
         onChanged: (String? newValue){
          dropdownValue=newValue!;
          widget.controller= newValue;
         },
        ),
    );
  }
}