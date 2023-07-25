import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/characters_api_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersProvider charactersProvider;

  CharactersCubit({
    required this.charactersProvider,
  }) : super(CharactersInitial());

  void fetchCharacters({required int pageNumber}) async {
    try {
      emit(CharactersLoading());
      final characters = await charactersProvider.fetchCharacters(pageNumber);
      emit(CharactersLoaded(characters: characters));
    } catch (e) {
      emit(CharactersError(message: e.toString()));
    }
  }
}
