import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/models/info_pages_model.dart';

class EpisodesApiModel {
  final InfoPages info;
  final List<Episode> episodies;

  EpisodesApiModel({
    required this.info,
    required this.episodies,
  });

  factory EpisodesApiModel.fromJson(Map<String, dynamic> json) =>
      EpisodesApiModel(
        info: InfoPages.fromJson(json["info"]),
        episodies: List<Episode>.from(
          json["results"].map((x) => Episode.fromJson(x)),
        ),
      );
}
