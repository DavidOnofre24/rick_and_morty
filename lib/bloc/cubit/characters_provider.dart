import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';

BlocProvider<CharactersCubit> charactersCubitProvider() {
  return BlocProvider<CharactersCubit>(
    create: (context) => CharactersCubit(
      charactersProvider: getIt.get(),
    )..fetchCharacters(pageNumber: 0),
  );
}
