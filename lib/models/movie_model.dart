class MovieModel {
  int? id;
  int? favorite;
  String? movie;

  MovieModel({this.id, this.favorite, this.movie});

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['idMovie'],
      favorite: map['favorite'],
      movie: map['movie'],
    );
  }
}
