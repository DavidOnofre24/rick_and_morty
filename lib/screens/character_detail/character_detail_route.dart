import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/navigation/navigation.dart';
import 'package:rick_and_morty_app/screens/character_detail/character_detail_screen.dart';
import 'package:rick_and_morty_app/screens/character_detail/cubit/character_detail_provider.dart';

class CharacterDetailRoute extends RouteBuilder {
  static String routeName = "/characters-detail";
  final int id;

  CharacterDetailRoute(
    BuildContext context, {
    required this.id,
    super.rootNavigator,
  }) : super(context: context);

  @override
  Route getRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            characterDetailCubitProvider(id),
          ],
          child: const CharacterDetailScreen(),
        );
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
