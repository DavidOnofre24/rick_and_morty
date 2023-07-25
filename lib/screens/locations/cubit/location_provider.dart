import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';
import 'package:rick_and_morty_app/screens/locations/cubit/location_cubit.dart';

BlocProvider<LocationCubit> locationCubitProvider() {
  return BlocProvider<LocationCubit>(
    create: (context) => LocationCubit(
      locationsProvider: getIt.get(),
    ),
  );
}
