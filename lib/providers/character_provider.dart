import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:rick_and_morty_app/models/characters_api_model.dart';

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
}
