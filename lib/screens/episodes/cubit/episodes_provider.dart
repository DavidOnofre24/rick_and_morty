import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';
import 'package:rick_and_morty_app/screens/episodes/cubit/episodes_cubit.dart';

BlocProvider<EpisodesCubit> episodesCubitProvider() {
  return BlocProvider<EpisodesCubit>(
    create: (context) => EpisodesCubit(
      episodesProvider: getIt.get(),
    ),
  );
}
