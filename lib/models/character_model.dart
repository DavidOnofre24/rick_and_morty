import 'package:rick_and_morty_app/models/gender_enum.dart';
import 'package:rick_and_morty_app/models/location_model.dart';
import 'package:rick_and_morty_app/models/species_enum.dart';
import 'package:rick_and_morty_app/models/status_enum.dart';

class Character {
  final int id;
  final String name;
  final Status status;
  final Species species;
  final String type;
  final Gender gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]] ?? Status.unknown,
        species: speciesValues.map[json["species"]] ?? Species.unknown,
        type: json["type"],
        gender: genderValues.map[json["gender"]] ?? Gender.unknown,
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}
