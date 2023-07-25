import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/dependecies_injetion/characters.dart';
import 'package:rick_and_morty_app/dependecies_injetion/core.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await configureCore(getIt);
  configureCharacters(getIt);
  await getIt.allReady();
}
