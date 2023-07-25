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
  const EpisodesLoaded({
    required this.episodes,
    required this.isLoadMore,
  });

  @override
  List<Object> get props => [episodes, isLoadMore];
}

class EpisodesError extends EpisodesState {
  final String message;
  const EpisodesError({required this.message});

  @override
  List<Object> get props => [message];
}
