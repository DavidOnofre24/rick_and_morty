import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';
import 'package:rick_and_morty_app/screens/character_detail/cubit/character_detail_cubit.dart';

BlocProvider<CharacterDetailCubit> characterDetailCubitProvider(int id) {
  return BlocProvider<CharacterDetailCubit>(
    create: (context) => CharacterDetailCubit(
      charactersProvider: getIt.get(),
    )..getCharacterDetail(id: id),
  );
}
