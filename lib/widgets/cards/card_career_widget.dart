import 'package:flutter/material.dart';
import 'package:pmsn20232/database/career_model.dart';
import 'package:pmsn20232/models/Career_model.dart';
import 'package:pmsn20232/services/provider/career_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardCareerWidget extends StatelessWidget {
  CareerController careerController;
  CareerModel careerModel;
  CardCareerWidget(this.careerController,
      {super.key, required this.careerModel});
  @override
  Widget build(BuildContext context) {
    // final careerProvider = Provider.of<CareerProvider>(context);
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
              Text('${careerModel.career!}'),
              const Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ],
      ),
    );
  }
}
