part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final bool isLoadMore;
  final List<Character> characters;

  const CharactersLoaded({required this.characters, required this.isLoadMore});

  @override
  List<Object> get props => [characters, isLoadMore];
}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError({required this.message});
}
