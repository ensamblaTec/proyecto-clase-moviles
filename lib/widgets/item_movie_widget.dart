import 'package:flutter/material.dart';
import 'package:pmsn20232/models/popular_model.dart';

Widget itemMovieWidget(PopularModel movie, context) {
  return GestureDetector(
    child: const FadeInImage(
      placeholder: AssetImage('assets/loading.gif'),
      image: NetworkImage(''),
    ),
    onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
  );
}