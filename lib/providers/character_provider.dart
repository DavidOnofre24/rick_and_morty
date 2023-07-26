import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:rick_and_morty_app/models/character/character_detail_model.dart';
import 'dart:convert';

import 'package:rick_and_morty_app/models/character/characters_api_model.dart';

class CharactersProvider {
  final Client client;
  CharactersProvider({required this.client});

  Future<CharactersApiModel> fetchCharacters(int pageNumber) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/character")
        .replace(queryParameters: {"page": pageNumber.toString()});
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return CharactersApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<CharacterDetail> getCharacter(int id) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/character/$id");
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return CharacterDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<CharactersApiModel> searchCharacter({
    String? name,
    String? status,
    String? species,
    String? gender,
    required int pageNumber,
  }) async {
    final query = {
      if (name != null) "name": name,
      if (status != null) "status": status,
      if (species != null) "species": species,
      if (species != gender) "gender": gender,
      "page": pageNumber.toString(),
    };
    final uri = Uri.parse("https://rickandmortyapi.com/api/character").replace(
      queryParameters: query,
    );
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return CharactersApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('No data found');
    }
  }
}
