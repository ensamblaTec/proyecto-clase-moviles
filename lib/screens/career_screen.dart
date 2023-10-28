import 'package:flutter/material.dart';
import 'package:pmsn20232/database/career_model.dart';
import 'package:pmsn20232/models/Career_model.dart';
import 'package:pmsn20232/widgets/cards/card_career_widget.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:pmsn20232/widgets/filter_text_widget.dart';

class CareerScreen extends StatefulWidget {
  final String title;
  const CareerScreen({super.key, required this.title});
  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  CareerController? careerController;
  List<CareerModel>? selectedUserList = [];
  List<String>? selectedCareerList = [];
  List<String> dropDownValues = [];
  DropDownWidget? dropDownFilter;
  FilterTextWidget? filterText;

  @override
  void initState() {
    super.initState();
    careerController = CareerController();
    dropDownFilter = DropDownWidget(controller: 'Todo', values: dropDownValues);
    filterText = FilterTextWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addCareer')
                    .then((value) => {setState(() {})});
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          filterText!,
          filterText!.txtController.text.isNotEmpty
              ? getFilterList()
              : getList()
        ],
      ), // children: [filtered(context)],
    );
  }

  FutureBuilder<List<CareerModel>> getList() {
    print("entro sin filtro");
    return FutureBuilder(
        future: careerController!.get(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data);
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error!'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }

  FutureBuilder<List<CareerModel>> getFilterList() {
    print("entro filtro");
    return FutureBuilder(
        future:
            careerController!.getCareerByName(filterText!.txtController.text),
        builder:
            (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data);
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error!'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }

  Widget buildList(info) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
      child: ListView.builder(
          itemCount: info!.length, //snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return CardCareerWidget(
              careerController!, careerModel: info[index],
              // CareerModel: info![index],
            );
          }),
    );
  }
}
