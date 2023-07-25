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
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is CharactersLoaded) {
        emit(CharactersLoaded(
            isLoadMore: true, characters: List.of(allCharacters)));
      } else {
        emit(CharactersLoading());
      }

      final charactersApiModel =
          await charactersProvider.fetchCharacters(currentPage);

      if (charactersApiModel.characters.isNotEmpty) {
        allCharacters.addAll(charactersApiModel.characters);

        pageSize = charactersApiModel.info.pages;

        emit(CharactersLoaded(
            characters: List.of(allCharacters), isLoadMore: false));
        currentPage++;
      } else {
        emit(const CharactersError(
            message: "No hay más personajes disponibles."));
      }
    } catch (e) {
      emit(CharactersError(message: e.toString()));
    }
  }
}
