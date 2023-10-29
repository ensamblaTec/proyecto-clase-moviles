import 'package:flutter/material.dart';

class TxtTextField extends StatelessWidget {
  TxtTextField({super.key, this.placeholder = "Empty"});
  final String? placeholder;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: Text(placeholder!),
        border: const OutlineInputBorder(),
      ),
      controller: controller,
    );
  }

  String get text => controller.text;
}
