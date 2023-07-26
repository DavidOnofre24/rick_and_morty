import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character/character_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersProvider charactersProvider;

  CharactersCubit({
    required this.charactersProvider,
  }) : super(CharactersInitial());

  int currentPage = 1;
  var pageSize = 2;
  List<Character> allCharacters = [];

  void fetchCharacters() async {
    try {
      if (state is CharactersLoaded) {
        final currentState = state as CharactersLoaded;
        if (currentState.isLoadMore) {
          return;
        }
        if (currentState.isSearch) {
          currentPage = 1;
          allCharacters = [];
          pageSize = 2;
        }
      }

      if (state is CharactersError) {
        currentPage = 1;
        pageSize = 2;
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is CharactersLoaded) {
        emit(CharactersLoaded(
            isSearch: false,
            isLoadMore: true,
            characters: allCharacters.toSet().toList()));
      } else {
        emit(CharactersLoading());
      }

      final charactersApiModel =
          await charactersProvider.fetchCharacters(currentPage);

      if (charactersApiModel.characters.isNotEmpty) {
        allCharacters.addAll(charactersApiModel.characters);

        pageSize = charactersApiModel.info.pages;

        emit(CharactersLoaded(
            isSearch: false,
            characters: allCharacters.toSet().toList(),
            isLoadMore: false));
        currentPage++;
      } else {
        emit(const CharactersError(
            message: "There are no characters available."));
      }
    } catch (e) {
      emit(CharactersError(message: e.toString()));
    }
  }

  void setName(String name) async {
    final currentState = state as CharactersLoaded;
    currentPage = 0;
    if (name.isEmpty) {
      allCharacters = [];
      fetchCharacters();
    }
    emit(CharactersLoaded(
      isSearch: false,
      isLoadMore: false,
      characters: const [],
      filters: currentState.filters.copyWith(name: name),
    ));
    allCharacters = [];
    searchCharacter();
  }

  void setStatus(String status) async {
    final currentState = state as CharactersLoaded;
    currentPage = 0;
    if (status.isEmpty) {
      allCharacters = [];
      fetchCharacters();
    }
    emit(CharactersLoaded(
      isSearch: false,
      isLoadMore: false,
      characters: const [],
      filters: currentState.filters.copyWith(status: status),
    ));
    allCharacters = [];
    searchCharacter();
  }

  void setSpecies(String species) async {
    final currentState = state as CharactersLoaded;
    currentPage = 0;
    if (species.isEmpty) {
      allCharacters = [];
      fetchCharacters();
    }
    emit(CharactersLoaded(
      isSearch: false,
      isLoadMore: false,
      characters: const [],
      filters: currentState.filters.copyWith(species: species),
    ));
    allCharacters = [];
    searchCharacter();
  }

  void setGender(String gender) {
    final currentState = state as CharactersLoaded;
    currentPage = 0;
    if (gender.isEmpty) {
      allCharacters = [];
      fetchCharacters();
    }
    emit(CharactersLoaded(
      isSearch: false,
      isLoadMore: false,
      characters: const [],
      filters: currentState.filters.copyWith(gender: gender),
    ));
    allCharacters = [];
    searchCharacter();
  }

  void searchCharacter() async {
    try {
      final current = state as CharactersLoaded;

      if (state is CharactersLoaded) {
        final currentState = state as CharactersLoaded;
        if (currentState.isLoadMore) {
          return;
        }
        if (!currentState.isSearch) {
          currentPage = 0;
          pageSize = 2;
        }
      }

      if (state is CharactersError) {
        currentPage = 0;
        pageSize = 2;
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is CharactersLoaded) {
        emit(CharactersLoaded(
            isSearch: true,
            isLoadMore: true,
            filters: current.filters,
            characters: allCharacters.toSet().toList()));
      } else {
        emit(CharactersLoading());
      }

      final charactersApiModel = await charactersProvider.searchCharacter(
        pageNumber: currentPage,
        gender: current.filters.gender,
        name: current.filters.name,
        species: current.filters.species,
        status: current.filters.status,
      );

      if (charactersApiModel.characters.isNotEmpty) {
        allCharacters.addAll(charactersApiModel.characters);

        pageSize = charactersApiModel.info.pages;

        emit(CharactersLoaded(
          isSearch: true,
          characters: allCharacters.toSet().toList(),
          isLoadMore: false,
          filters: current.filters,
        ));

        currentPage++;
      } else {
        emit(const CharactersError(message: "There are no characters available."));
      }
    } catch (e) {
      emit(CharactersError(message: e.toString()));
    }
  }
}
