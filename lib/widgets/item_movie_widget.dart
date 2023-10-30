import 'package:flutter/material.dart';
import 'package:pmsn20232/models/api/popular_model.dart';

Widget itemMovieWidget(PopularModel movie, context) {
  return GestureDetector(
    child: FadeInImage(
      fadeInDuration: const Duration(milliseconds: 500),
      placeholder: const AssetImage('assets/loading.gif'),
      image:
          NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
    ),
    onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
  );
}
