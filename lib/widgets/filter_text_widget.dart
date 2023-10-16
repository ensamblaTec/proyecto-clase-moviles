import 'package:flutter/material.dart';

class FilterTextWidget extends StatelessWidget {
  FilterTextWidget({super.key});

  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          margin: const EdgeInsets.all(10),
          child: ListView(children: [
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Search Bar'), border: OutlineInputBorder(),
            ),
            controller: txtController,
          ),
          ElevatedButton(onPressed: () {
            
          }, child: const Text("Find"),)
          ],)
        );
  }
}