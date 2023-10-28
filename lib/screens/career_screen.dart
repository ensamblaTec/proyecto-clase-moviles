import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/Career_model.dart';
import 'package:pmsn20232/widgets/card_career_widget.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:pmsn20232/widgets/filter_text_widget.dart';

class CareerScreen extends StatefulWidget {
  final String title;
  const CareerScreen({super.key, required this.title});
  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  AgendaDB? agendaDB;
  List<CareerModel>? selectedUserList = [];
  List<String>? selectedCareerList = [];
  List<String> dropDownValues = [];
  DropDownWidget? dropDownFilter;
  FilterTextWidget? filterText;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
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
        children: [filterText!, getList()],
      ), // children: [filtered(context)],
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFilterDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void openFilterDialog(context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Filter"),
              content: const Text("Choose option"),
              actions: [
                dropDownFilter!,
                ElevatedButton(
                  onPressed: () => setState(() {
                    Navigator.pop(context);
                  }),
                  child: const Text("OK"),
                )
              ],
            ));
  }

  FutureBuilder<List<CareerModel>> getList() {
    return FutureBuilder(
        future: agendaDB!.getAllCareer(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: ListView.builder(
                  itemCount: snapshot.data!.length, //snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardCareerWidget(
                      agendaDB!,
                      careerModel: snapshot.data![index],
                    );
                  }),
            );
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
              agendaDB!, careerModel: info,
              // CareerModel: info![index],
            );
          }),
    );
  }
}
