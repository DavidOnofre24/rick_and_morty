import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

configureCharacters(GetIt getIt) {
  getIt.registerFactory<CharactersProvider>(
    () => CharactersProvider(
      client: getIt.get(),
    ),
  );
}
