import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/providers/locations_provider.dart';

configureLocations(GetIt getIt) {
  getIt.registerFactory<LocationsProvider>(
    () => LocationsProvider(
      client: getIt.get(),
    ),
  );
}
