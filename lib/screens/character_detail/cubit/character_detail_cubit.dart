import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character/character_detail_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

part 'character_detail_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final CharactersProvider charactersProvider;
  CharacterDetailCubit({required this.charactersProvider})
      : super(CharacterDetailInitial());

  void getCharacterDetail({required int id}) async {
    try {
      emit(CharacterDetailLoading());
      final characterDetail = await charactersProvider.getCharacter(id);
      emit(CharacterDetailLoaded(characterDetail: characterDetail));
    } catch (e) {
      emit(CharacterDetailError(message: e.toString()));
    }
  }
}
