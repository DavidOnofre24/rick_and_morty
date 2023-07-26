import 'dart:convert';

import 'package:http/http.dart';
import 'package:rick_and_morty_app/models/location/location_api_model.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';

class LocationsProvider {
  final Client client;
  LocationsProvider({required this.client});

  Future<LocationsApiModel> fetchLocations(int pageNumber) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/location")
        .replace(queryParameters: {"page": pageNumber.toString()});
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return LocationsApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Location> getLocation(int id) async {
    final uri = Uri.parse("https://rickandmortyapi.com/api/location/$id");
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<LocationsApiModel> searchLocation({
    String? name,
    String? type,
    String? dimension,
    required int pageNumber,
  }) async {
    final query = {
      if (name != null) "name": name,
      if (type != null) "type": type,
      if (dimension != null) "dimension": dimension,
      "page": pageNumber.toString(),
    };
    final uri = Uri.parse("https://rickandmortyapi.com/api/location").replace(
      queryParameters: query,
    );
    final response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return LocationsApiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('No data found');
    }
  }
}
