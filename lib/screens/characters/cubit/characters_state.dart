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
  final bool isSearch;
  final Filters filters;

  const CharactersLoaded({
    required this.characters,
    required this.isLoadMore,
    required this.isSearch,
    this.filters = const Filters(),
  });

  @override
  List<Object> get props => [
        characters,
        isLoadMore,
        isSearch,
        filters,
      ];
}

class Filters extends Equatable {
  final String? name;
  final String? status;
  final String? species;
  final String? gender;

  const Filters({this.name, this.status, this.species, this.gender});

  Filters copyWith({
    String? name,
    String? status,
    String? species,
    String? gender,
  }) {
    return Filters(
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        gender: gender ?? this.gender);
  }

  @override
  List<Object?> get props => [name, status, species, gender];
}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError({required this.message});
}
