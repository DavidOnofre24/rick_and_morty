part of 'episodes_cubit.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();

  @override
  List<Object> get props => [];
}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<Episode> episodes;
  final bool isLoadMore;
  final bool isSearch;
  final Filters filters;
  const EpisodesLoaded({
    required this.episodes,
    required this.isLoadMore,
    required this.isSearch,
    this.filters = const Filters(),
  });

  @override
  List<Object> get props => [
        episodes,
        isLoadMore,
        isSearch,
        filters,
      ];
}

class Filters extends Equatable {
  final String? name;
  final String? episode;

  const Filters({this.name, this.episode});

  Filters copyWith({String? name, String? episode}) {
    return Filters(
      name: name ?? this.name,
      episode: episode ?? this.episode,
    );
  }

  @override
  List<Object?> get props => [name, episode];
}

class EpisodesError extends EpisodesState {
  final String message;
  const EpisodesError({required this.message});

  @override
  List<Object> get props => [message];
}
