import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';

class LocationDetailScreen extends StatelessWidget {
  final Location location;
  const LocationDetailScreen({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(location.name),
      ),
    );
  }
}
