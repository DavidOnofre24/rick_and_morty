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
        if (currentState.isSearch) {
          currentPage = 1;
          allEpisodes = [];
          pageSize = 2;
        }
      }

      if (state is EpisodesError) {
        currentPage = 1;
        pageSize = 2;
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is EpisodesLoaded) {
        emit(EpisodesLoaded(
          isLoadMore: true,
          episodes: allEpisodes.toSet().toList(),
          isSearch: false,
        ));
      } else {
        emit(EpisodesLoading());
      }

      final episodeApiModel = await episodesProvider.fetchEpisodes(currentPage);

      if (episodeApiModel.episodes.isNotEmpty) {
        allEpisodes.addAll(episodeApiModel.episodes);

        pageSize = episodeApiModel.info!.pages;

        emit(EpisodesLoaded(
          episodes: allEpisodes.toSet().toList(),
          isLoadMore: false,
          isSearch: false,
        ));
        currentPage++;
      } else {
        emit(const EpisodesError(message: "There are no episodes available."));
      }
    } catch (e) {
      emit(EpisodesError(message: e.toString()));
    }
  }

  void setName(String name) async {
    if (name.isEmpty || state is EpisodesError) {
      allEpisodes = [];
      fetchEpisodies();
      return;
    }
    final currentState = state as EpisodesLoaded;
    currentPage = 0;

    emit(EpisodesLoaded(
      isSearch: false,
      isLoadMore: false,
      episodes: const [],
      filters: currentState.filters.copyWith(name: name),
    ));
    allEpisodes = [];
    searchEpisode();
  }

  void setEpisode(String episode) async {
    if (episode.isEmpty || state is EpisodesError) {
      allEpisodes = [];
      fetchEpisodies();
      return;
    }
    final currentState = state as EpisodesLoaded;
    currentPage = 0;

    emit(EpisodesLoaded(
      isSearch: false,
      isLoadMore: false,
      episodes: const [],
      filters: currentState.filters.copyWith(episode: episode),
    ));
    allEpisodes = [];
    searchEpisode();
  }

  void searchEpisode() async {
    try {
      final current = state as EpisodesLoaded;

      if (state is EpisodesLoaded) {
        final currentState = state as EpisodesLoaded;
        if (currentState.isLoadMore) {
          return;
        }
        if (!currentState.isSearch) {
          currentPage = 0;
          pageSize = 2;
        }
      }

      if (state is EpisodesError) {
        currentPage = 0;
        pageSize = 2;
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is EpisodesLoaded) {
        emit(EpisodesLoaded(
            isSearch: true,
            isLoadMore: true,
            filters: current.filters,
            episodes: allEpisodes.toSet().toList()));
      } else {
        emit(EpisodesLoading());
      }

      final episodesApiModel = await episodesProvider.searchEpisode(
        pageNumber: currentPage,
        episode: current.filters.episode,
        name: current.filters.name,
      );

      if (episodesApiModel.episodes.isNotEmpty) {
        allEpisodes.addAll(episodesApiModel.episodes);

        pageSize = episodesApiModel.info!.pages;

        emit(EpisodesLoaded(
          isSearch: true,
          episodes: allEpisodes.toSet().toList(),
          isLoadMore: false,
          filters: current.filters,
        ));

        currentPage++;
      } else {
        emit(const EpisodesError(message: "There are no episodes available."));
      }
    } catch (e) {
      emit(EpisodesError(message: e.toString()));
    }
  }
}
