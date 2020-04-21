class Country {
  int id;
  String name;
  String shortName;
  String latitude;
  String longitude;
  int population;

  Country(this.id, this.name, this.shortName, this.latitude, this.longitude,
      this.population);

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
  }
}