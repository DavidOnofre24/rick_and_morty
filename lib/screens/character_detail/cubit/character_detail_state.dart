part of 'character_detail_cubit.dart';

abstract class CharacterDetailState {}

class CharacterDetailInitial extends CharacterDetailState {}

class CharacterDetailLoading extends CharacterDetailState {}

class CharacterDetailLoaded extends CharacterDetailState {
  final CharacterDetail characterDetail;

  CharacterDetailLoaded({required this.characterDetail});
}

class CharacterDetailError extends CharacterDetailState {
  final String message;

  CharacterDetailError({required this.message});
}
