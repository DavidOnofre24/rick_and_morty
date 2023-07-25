import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/navigation/navigation.dart';
import 'package:rick_and_morty_app/screens/episode_detail/episode_detail_screen.dart';

class EpisodeDetailRoute extends RouteBuilder {
  static String routeName = "/episode-detail";
  final Episode episode;

  EpisodeDetailRoute(
    BuildContext context, {
    super.rootNavigator,
    required this.episode,
  }) : super(context: context);

  @override
  Route getRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return EpisodeDetailScreen(episode: episode);
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
