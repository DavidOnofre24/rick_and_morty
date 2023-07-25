import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/navigation/navigation.dart';
import 'package:rick_and_morty_app/screens/characters/cubit/characters_provider.dart';
import 'package:rick_and_morty_app/screens/episodes/cubit/episodes_provider.dart';
import 'package:rick_and_morty_app/screens/home/home_screen.dart';
import 'package:rick_and_morty_app/screens/locations/cubit/location_provider.dart';

class HomeRoute extends RouteBuilder {
  static String routeName = "/home";

  HomeRoute(
    BuildContext context, {
    super.rootNavigator,
  }) : super(context: context);

  @override
  Route getRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            charactersCubitProvider(),
            locationCubitProvider(),
            episodesCubitProvider(),
          ],
          child: const HomeScreen(),
        );
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
