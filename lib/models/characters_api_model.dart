import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/models/info_pages_model.dart';

class CharactersApiModel {
  final InfoPages info;
  final List<Character> characters;

  CharactersApiModel({
    required this.info,
    required this.characters,
  });

  factory CharactersApiModel.fromJson(Map<String, dynamic> json) =>
      CharactersApiModel(
        info: InfoPages.fromJson(json["info"]),
        characters: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );
}
