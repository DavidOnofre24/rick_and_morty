import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';
import 'package:rick_and_morty_app/screens/characters/cubit/characters_cubit.dart';

BlocProvider<CharactersCubit> charactersCubitProvider() {
  return BlocProvider<CharactersCubit>(
    create: (context) => CharactersCubit(
      charactersProvider: getIt.get(),
    ),
  );
}
