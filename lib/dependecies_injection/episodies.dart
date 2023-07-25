import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/providers/episodes_provider.dart';

configureEpisodies(GetIt getIt) {
  getIt.registerFactory<EpisodesProvider>(
    () => EpisodesProvider(
      client: getIt.get(),
    ),
  );
}
