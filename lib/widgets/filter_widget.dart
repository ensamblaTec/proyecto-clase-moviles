import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/services/provider/career_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FilterWidget extends StatefulWidget {
  Function methodSearch;
  TextEditingController txtController = TextEditingController();

  FilterWidget({super.key, required this.methodSearch});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  AgendaDB agendaDB = AgendaDB();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CareerProvider>(context);
    return Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Search Bar'),
                border: OutlineInputBorder(),
              ),
              controller: widget.txtController,
            ),
            ElevatedButton(
              onPressed: () {
                prov.isUpdated = true;
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                prov.notifyListeners();
              },
              child: const Text("Find"),
            )
          ],
        ));
  }
}
