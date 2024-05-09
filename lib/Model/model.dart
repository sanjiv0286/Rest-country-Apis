// *Represents the data and business logic.
// *Define a model class to represent a country
class Country {
  final String name;
  final String capital;
  final int population;
  final String flag;
  final String continent;
  final String subregion;
//
  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.flag,
    required this.continent,
    required this.subregion,
  });

  // Factory method to convert JSON data to Country object
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'N/A',
      capital: json['capital'] != null ? json['capital'][0] ?? 'N/A' : 'N/A',
      population: json['population'] ?? 0,
      flag: json['flags'] != null ? json['flags']['svg'] ?? 'N/A' : 'N/A',
      continent: json['region'] ?? 'N/A',
      subregion: json['subregion'] ?? 'N/A',
    );
  }
}
