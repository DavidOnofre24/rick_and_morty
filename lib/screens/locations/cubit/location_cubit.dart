import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';
import 'package:rick_and_morty_app/providers/locations_provider.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationsProvider locationsProvider;
  LocationCubit({required this.locationsProvider}) : super(LocationInitial());

  int currentPage = 0;
  var pageSize = 2;
  List<Location> allLocations = [];

  void fetchLocations() async {
    try {
      if (state is LocationLoaded) {
        final currentState = state as LocationLoaded;
        if (currentState.isLoadMore) {
          return;
        }
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is LocationLoaded) {
        emit(
            LocationLoaded(isLoadMore: true, locations: List.of(allLocations)));
      } else {
        emit(LocationLoading());
      }

      final locationsApiModel =
          await locationsProvider.fetchLocations(currentPage);

      if (locationsApiModel.locations.isNotEmpty) {
        allLocations.addAll(locationsApiModel.locations);
        pageSize = locationsApiModel.info.pages;

        emit(LocationLoaded(
            locations: List.of(allLocations), isLoadMore: false));
        currentPage++;
      } else {
        emit(const LocationError(error: "No hay más ubicaciones disponibles."));
      }
    } catch (e) {
      emit(LocationError(error: e.toString()));
    }
  }
}
