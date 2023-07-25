import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersProvider charactersProvider;

  CharactersCubit({
    required this.charactersProvider,
  }) : super(CharactersInitial());

  int currentPage = 1;
  var pageSize = 0;
  List<Character> allCharacters = [];

  void fetchCharacters() async {
    try {
      if (state is CharactersLoading) {
        return;
      }

      final charactersApiModel =
          await charactersProvider.fetchCharacters(currentPage);

      if (charactersApiModel.characters.isNotEmpty) {
        allCharacters.addAll(charactersApiModel.characters);

        emit(CharactersLoaded(characters: List.of(allCharacters)));
        currentPage++;
      } else {
        emit(CharactersError(message: "No hay más personajes disponibles."));
      }
    } catch (e) {
      emit(CharactersError(message: e.toString()));
    }
  }
}
