import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/models/info_pages_model.dart';

class EpisodesApiModel {
  final InfoPages? info;
  final List<Episode> episodes;

  EpisodesApiModel({
    required this.info,
    required this.episodes,
  });

  factory EpisodesApiModel.fromJson(Map<String, dynamic> json) =>
      EpisodesApiModel(
        info: (json["info"] != null) ? InfoPages.fromJson(json["info"]) : null,
        episodes: List<Episode>.from(
          json["results"].map((x) => Episode.fromJson(x)),
        ),
      );
}
