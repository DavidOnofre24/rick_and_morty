import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/providers/episodes_provider.dart';

part 'episodes_state.dart';

class EpisodesCubit extends Cubit<EpisodesState> {
  final EpisodesProvider episodesProvider;
  EpisodesCubit({
    required this.episodesProvider,
  }) : super(EpisodesInitial());

  int currentPage = 0;
  var pageSize = 2;
  List<Episode> allEpisodes = [];

  void fetchEpisodies() async {
    try {
      if (state is EpisodesLoaded) {
        final currentState = state as EpisodesLoaded;
        if (currentState.isLoadMore) {
          return;
        }
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is EpisodesLoaded) {
        emit(EpisodesLoaded(isLoadMore: true, episodes: List.of(allEpisodes)));
      } else {
        emit(EpisodesLoading());
      }

      final episodeApiModel = await episodesProvider.fetchEpisodes(currentPage);

      if (episodeApiModel.episodes.isNotEmpty) {
        allEpisodes.addAll(episodeApiModel.episodes);

        pageSize = episodeApiModel.info.pages;

        emit(EpisodesLoaded(episodes: List.of(allEpisodes), isLoadMore: false));
        currentPage++;
      } else {
        emit(
            const EpisodesError(message: "No hay más personajes disponibles."));
      }
    } catch (e) {
      emit(EpisodesError(message: e.toString()));
    }
  }
}
