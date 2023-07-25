import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/dependecies_injection/characters.dart';
import 'package:rick_and_morty_app/dependecies_injection/core.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await configureCore(getIt);
  configureCharacters(getIt);
  await getIt.allReady();
}
