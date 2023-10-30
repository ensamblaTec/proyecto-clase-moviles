class CreditsModel {
  String? knownForDepartment;
  String? name;
  String? img;

  CreditsModel({
    this.name,
    this.img,
    this.knownForDepartment,
  });

  factory CreditsModel.fromMap(Map<String, dynamic> map) {
    return CreditsModel(
      name: map['name'],
      img: map['profile_path'],
      knownForDepartment: map['known_for_department'],
    );
  }
}
