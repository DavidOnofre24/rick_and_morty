import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';
import 'package:rick_and_morty_app/navigation/navigation.dart';
import 'package:rick_and_morty_app/screens/location_detail/location_detail_screen.dart';

class LocationDetailRoute extends RouteBuilder {
  static String routeName = "/location-detail";
  final Location location;

  LocationDetailRoute(
    BuildContext context, {
    super.rootNavigator,
    required this.location,
  }) : super(context: context);

  @override
  Route getRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return LocationDetailScreen(location: location);
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
