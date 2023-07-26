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
        emit(LocationLoaded(
          isLoadMore: true,
          locations: allLocations.toSet().toList(),
          isSearch: false,
        ));
      } else {
        emit(LocationLoading());
      }

      final locationsApiModel =
          await locationsProvider.fetchLocations(currentPage);

      if (locationsApiModel.locations.isNotEmpty) {
        allLocations.addAll(locationsApiModel.locations);
        pageSize = locationsApiModel.info.pages;

        emit(LocationLoaded(
          locations: allLocations.toSet().toList(),
          isLoadMore: false,
          isSearch: false,
        ));
        currentPage++;
      } else {
        emit(const LocationError(message: "There are no locations available."));
      }
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  void setName(String name) async {
    if (name.isEmpty || state is LocationError) {
      allLocations = [];
      fetchLocations();
      return;
    }
    final currentState = state as LocationLoaded;
    currentPage = 0;

    emit(LocationLoaded(
      isSearch: false,
      isLoadMore: false,
      locations: const [],
      filters: currentState.filters.copyWith(name: name),
    ));
    allLocations = [];
    searchLocation();
  }

  void setDimension(String dimension) async {
    if (dimension.isEmpty || state is LocationError) {
      allLocations = [];
      fetchLocations();
      return;
    }
    final currentState = state as LocationLoaded;
    currentPage = 0;

    emit(LocationLoaded(
      isSearch: false,
      isLoadMore: false,
      locations: const [],
      filters: currentState.filters.copyWith(dimension: dimension),
    ));
    allLocations = [];
    searchLocation();
  }

  void setType(String type) async {
    if (type.isEmpty || state is LocationError) {
      allLocations = [];
      fetchLocations();
      return;
    }
    final currentState = state as LocationLoaded;
    currentPage = 0;

    emit(LocationLoaded(
      isSearch: false,
      isLoadMore: false,
      locations: const [],
      filters: currentState.filters.copyWith(type: type),
    ));
    allLocations = [];
    searchLocation();
  }

  void searchLocation() async {
    try {
      final current = state as LocationLoaded;

      if (state is LocationLoaded) {
        final currentState = state as LocationLoaded;
        if (currentState.isLoadMore) {
          return;
        }
        if (!currentState.isSearch) {
          currentPage = 0;
          pageSize = 2;
        }
      }

      if (state is LocationError) {
        currentPage = 0;
        pageSize = 2;
      }

      if (pageSize < currentPage) {
        return;
      }

      if (state is LocationLoaded) {
        emit(LocationLoaded(
            isSearch: true,
            isLoadMore: true,
            filters: current.filters,
            locations: allLocations.toSet().toList()));
      } else {
        emit(LocationLoading());
      }

      final locationsApiModel = await locationsProvider.searchLocation(
        pageNumber: currentPage,
        type: current.filters.type,
        dimension: current.filters.dimension,
        name: current.filters.name,
      );

      if (locationsApiModel.locations.isNotEmpty) {
        allLocations.addAll(locationsApiModel.locations);

        pageSize = locationsApiModel.info.pages;

        emit(LocationLoaded(
          isSearch: true,
          locations: allLocations.toSet().toList(),
          isLoadMore: false,
          filters: current.filters,
        ));

        currentPage++;
      } else {
        emit(const LocationError(message: "There are no episodes available."));
      }
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }
}
