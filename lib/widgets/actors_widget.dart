import 'package:flutter/material.dart';

class ActorsWidget extends StatelessWidget {
  String? img;
  String? name;
  ActorsWidget({super.key, this.img, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        CircleAvatar(maxRadius: 10, backgroundImage: NetworkImage(img!)),
        Text(name!),
      ]),
    );
  }
}
