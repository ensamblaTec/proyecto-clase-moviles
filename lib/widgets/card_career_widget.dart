import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/Career_model.dart';
import 'package:pmsn20232/services/provider/tasks_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardCareerWidget extends StatelessWidget {
  AgendaDB agendaDB;
  CareerModel careerModel;
  CardCareerWidget(this.agendaDB, {super.key, required this.careerModel});
  @override
  Widget build(BuildContext context) {
    final careerModel = Provider.of<CareerModel>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${careerModel.career!}'),
              const Padding(padding: EdgeInsets.all(2)),
            ],
          ),
          const Expanded(
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
