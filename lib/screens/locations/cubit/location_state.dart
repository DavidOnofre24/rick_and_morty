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
  final bool isSearch;
  final Filters filters;

  const LocationLoaded({
    required this.locations,
    required this.isLoadMore,
    required this.isSearch,
    this.filters = const Filters(),
  });

  @override
  List<Object> get props => [
        locations,
        isLoadMore,
        isSearch,
        filters,
      ];
}

class Filters extends Equatable {
  final String? name;
  final String? type;
  final String? dimension;

  const Filters({
    this.name,
    this.type,
    this.dimension,
  });

  @override
  List<Object?> get props => [
        name,
        type,
        dimension,
      ];
  Filters copyWith({
    String? name,
    String? type,
    String? dimension,
  }) {
    return Filters(
      name: name ?? this.name,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
    );
  }
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object> get props => [message];
}
