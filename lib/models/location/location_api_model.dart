import 'package:rick_and_morty_app/models/info_pages_model.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';

class LocationsApiModel {
  final InfoPages info;
  final List<Location> locations;

  LocationsApiModel({
    required this.info,
    required this.locations,
  });

  factory LocationsApiModel.fromJson(Map<String, dynamic> json) =>
      LocationsApiModel(
        info: InfoPages.fromJson(json["info"]),
        locations: List<Location>.from(
          json["results"].map((x) => Location.fromJson(x)),
        ),
      );
}
