import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/models/episodes/episodes_api_model.dart';
import 'dart:convert';

class EpisodesProvider {
  final Client client;
  EpisodesProvider({required this.client});

  Future<EpisodesApiModel> fetchEpisodes(int pageNumber) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/episode")
        .replace(queryParameters: {"page": pageNumber.toString()});
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return EpisodesApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Episode> getEpisode(int id) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/episode/$id");
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Episode.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<EpisodesApiModel> searchEpisode({
    String? name,
    String? episode,
    required int pageNumber,
  }) async {
    final query = {
      if (name != null) "name": name,
      if (episode != null) "episode": episode,
      "page": pageNumber.toString(),
    };
    final uri = Uri.parse("https://rickandmortyapi.com/api/episode").replace(
      queryParameters: query,
    );
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return EpisodesApiModel.fromJson(json.decode(response.body));
    } else {
      return EpisodesApiModel.fromJson({"info": null, "results": []});
    }
  }
}
