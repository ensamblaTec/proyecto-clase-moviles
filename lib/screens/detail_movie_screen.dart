import 'package:flutter/material.dart';
import 'package:pmsn20232/models/api/credits_model.dart';
import 'package:pmsn20232/models/api/popular_model.dart';
import 'package:pmsn20232/network/api_popular.dart';
import 'package:pmsn20232/widgets/actors_widget.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  PopularModel? movie;

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list_sharp),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .8,
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie!.posterPath!}'),
            ),
          ),
          child: ListView(
            children: [
              Text("Detail Movie ${movie!.title!}"),
              Text("Detail Movie ${movie!.overview!}"),
              Row(
                children: [
                  const Text("Rating: "),
                  calculateRating(movie!.voteAverage!),
                ],
              ),
              Row(
                children: [
                  const Text("Actors: "),
                  getActors(movie!.id!),
                ],
              ),
            ],
          ),
        ));
  }

  Widget calculateRating(double rating) {
    int valInt = 10 - rating.toInt();
    double average = rating - valInt;
    List<IconData> iconData = [];
    for (var i = 0; i < 5; i++) {
      if (valInt > i) {
        iconData.add(Icons.star_rate);
      } else if (average > 0.5) {
        iconData.add(Icons.star_half);
        average = 0.0;
      } else {
        iconData.add(Icons.star_border);
      }
    }
    return Row(
      children: iconData.map((iconData) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            size: 48.0,
            color: Colors.blue,
          ),
        );
      }).toList(),
    );
  }

  FutureBuilder<List<CreditsModel>> getActors(int id) {
    return FutureBuilder(
      future: ApiPopular().getCredits(id),
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
            return const Center(
              child: Text("No data found"),
            );
          } else {
            final filterActor = data.map((e) {
              if (e.knownForDepartment! == "Acting") {
                return e;
              }
            }).toList();
            return ListView.builder(
              itemCount: filterActor.length,
              itemBuilder: (BuildContext context, int index) {
                print(filterActor[index]!.img);
                print(filterActor[index]!.name);
                var img = 'https://pic.re/image';
                if (filterActor[index]!.img != null) {
                  img =
                      "https://image.tmdb.org/t/p/w500/${filterActor[index]!.img}";
                }

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ActorsWidget(
                    name: filterActor[index]!.name!,
                    img: img,
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
