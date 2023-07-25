import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/navigation/navigation.dart';
import 'package:rick_and_morty_app/screens/characters/characters_screen.dart';
import 'package:rick_and_morty_app/screens/characters/cubit/characters_provider.dart';

class CharactersRoute extends RouteBuilder {
  static String routeName = "/characters";

  CharactersRoute(
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
          ],
          child: const CharactersScreen(),
        );
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
