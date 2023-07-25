import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final Episode episode;
  const EpisodeDetailScreen({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(episode.name),
      ),
    );
  }
}
