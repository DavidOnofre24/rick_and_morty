part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<Location> locations;
  final bool isLoadMore;

  const LocationLoaded({
    required this.locations,
    required this.isLoadMore,
  });

  @override
  List<Object> get props => [locations, isLoadMore];
}

class LocationError extends LocationState {
  final String error;

  const LocationError({required this.error});

  @override
  List<Object> get props => [error];
}
