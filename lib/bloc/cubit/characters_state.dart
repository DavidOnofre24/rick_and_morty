part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final CharactersApiModel characters;

  CharactersLoaded({required this.characters});
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError({required this.message});
}
