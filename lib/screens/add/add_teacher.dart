import 'package:flutter/material.dart';
import 'package:pmsn20232/database/career_controller.dart';
import 'package:pmsn20232/database/teacher_controller.dart';
import 'package:pmsn20232/models/teacher_model.dart';
import 'package:pmsn20232/services/provider/teacher_provider.dart';
import 'package:pmsn20232/utils/messages.dart';
import 'package:pmsn20232/widgets/dropdown_widget.dart';
import 'package:pmsn20232/widgets/text_field.dart';
import 'package:provider/provider.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  TeacherModel? args;

  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  DropDownWidget? dropDownWidget;
  List<String>? list;

  TeacherController? teacherController;

  @override
  void initState() {
    super.initState();
    teacherController = TeacherController();
  }

  void verifyIsEditting(data) async {
    if (data == null) {
      args = null;
      return;
    }

    args = data as TeacherModel;
    // txtConName.text = args!.name!;
    txtConName.text =
        txtConName.text.isNotEmpty ? args!.name! : txtConName.text;
    txtConEmail.text =
        txtConEmail.text.isNotEmpty ? args!.email! : txtConName.text;
  }

  FutureBuilder<List<String>> futureBuilder() {
    return FutureBuilder<List<String>>(
      future: CareerController()
          .getAllStringName(), // Llama a tu función que devuelve el Future<List<String>>
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga el Future, muestra un indicador de carga
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Si hay un error, muestra un mensaje de error
          return Text('Error: ${snapshot.error}');
        } else {
          // Una vez que el Future se completa con éxito, muestra los datos en un ListView
          final data = snapshot.data;
          if (data == null) {
            return DropDownWidget();
          }
          return DropDownWidget(
            values: data,
            controller: data[0],
            labelText: "Career",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherProvider>(context);
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      verifyIsEditting(data);
    }

    final textName = TxtTextField(
      placeholder: "Name Teacher",
    );

    final textEmail = TxtTextField(
      placeholder: "Email",
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: () {
        if (txtConName.text.isEmpty) {
          Messages().failMessage(Messages().empty, context);
          return;
        }
        args == null
            ? teacherController!.insert({
                'name': textName.text,
                'idCareer': dropDownWidget!.id,
                'email': textEmail.text,
              }).then((value) {
                if (value > 0) {
                  Messages().okMessage(Messages().okInsert, context);
                } else {
                  Messages().failMessage(Messages().failInsert, context);
                }
                provider.isUpdated = !provider.isUpdated;
                Navigator.pop(context);
              })
            : teacherController!.update({
                'idCareer': args!.idCareer!,
                'career': txtConName.text,
              }).then((value) {
                if (value > 0) {
                  Messages().okMessage(Messages().okUpdate, context);
                } else {
                  Messages().failMessage(Messages().failUpdate, context);
                }
                provider.isUpdated = !provider.isUpdated;
                Navigator.pop(context);
              });
      },
      child: const Text('Save Teacher'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${args == null ? 'Add' : 'Update'} Teacher"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textName,
            const Padding(padding: EdgeInsets.all(10)),
            textEmail,
            const Padding(padding: EdgeInsets.all(10)),
            futureBuilder(),
            const Expanded(child: Text("")),
            btnGuardar,
          ],
        ),
      ),
    );
  }
}
