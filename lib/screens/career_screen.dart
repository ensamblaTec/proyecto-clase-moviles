import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:pmsn20232/widgets/filter_text_widget.dart';
import 'package:provider/provider.dart';

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
                icon: const Icon(Icons.Career))
          ],
        ),
        body: Stack(
          children: [
              filterText!,
              futureBuilder()
          ],
        ),         // children: [filtered(context)],
        floatingActionButton: FloatingActionButton(
        onPressed: () => openFilterDialog(context),
        child: const Icon(Icons.add),
      ),);
  }
  void openFilterDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Filter"),
        content: const Text("Choose option"),
        actions: [
          dropDownFilter!,
          ElevatedButton(onPressed: () => setState(() {
            Navigator.pop(context);
          }), child: const Text("OK"),)
        ],
      )
    );
  }
  FutureBuilder<List<CareerModel>> futureBuilder() {
    final updateCareer = Provider.of<CareerProvider>(context);
    if (updateCareer.isUpdated) {
    return filterDataGetting(updateCareer);
    }
    return filterDataGetting(updateCareer);
  }
  FutureBuilder<List<CareerModel>> filterDataGetting(CareerProvider updateCareer) {
    switch(dropDownFilter!.controller) {
      case 'En proceso':
        return gettingByStatus(updateCareer, 'E');
      case 'Completado':
        return gettingByStatus(updateCareer, 'C');
      case 'Pendiente':
        return gettingByStatus(updateCareer, 'P');
      default:
        return FutureBuilder(
      future: agendaDB!.GETALLCareer(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
        if (updateCareer.isUpdated) {
          if(filterText!.filtered.isNotEmpty) {
            return buildList(filterText!.filtered);
          } else {
            return getList(snapshot);
          }
        } else {
          if(filterText!.filtered.isNotEmpty) {
            return buildList(filterText!.filtered);
          } else {
            return getList(snapshot);
          }
        }
      });
    }
  }
  FutureBuilder<List<CareerModel>> gettingByStatus(CareerProvider updateCareer, String status) {
    return FutureBuilder(
    future: agendaDB!.getCareerByStatus(status),
    builder:
        (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
      if (updateCareer.isUpdated) {
        return getList(snapshot);
      } else {
        return getList(snapshot);
      }
    });
  }
  FutureBuilder<List<CareerModel>> gettingByText(CareerProvider updateCareer, String nameCareer) {
    return FutureBuilder(
    future: agendaDB!.getCareerByText(nameCareer),
    builder:
        (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot) {
      if (updateCareer.isUpdated) {
        return getList(snapshot);
      } else {
        return getList(snapshot);
      }
    });
  }
  Widget getList(snapshot) {
    if (snapshot.hasData) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: ListView.builder(
            itemCount: snapshot.data!.length, //snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return CardCareerWidget(
                agendaDB!,
                CareerModel: snapshot.data![index],
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
  }
  Widget buildList(info) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: ListView.builder(
            itemCount: info!.length, //snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return CardCareerWidget(
                agendaDB!,
                CareerModel: info![index],
              );
            }),
      );
  }
}
