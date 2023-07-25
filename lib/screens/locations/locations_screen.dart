import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';
import 'package:rick_and_morty_app/screens/locations/cubit/location_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      context.read<LocationCubit>().fetchLocations();
    }
  }

  @override
  void initState() {
    context.read<LocationCubit>().fetchLocations();
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: context.read<LocationCubit>(),
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is LocationLoaded) {
          return ListView(controller: scrollController, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.locations.length ~/ 2,
                  itemBuilder: (context, index) {
                    int firstIndex = index * 2;
                    int secondIndex = index * 2 + 1;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LocationCard(
                          location: state.locations[firstIndex],
                        ),
                        LocationCard(
                          location: state.locations[secondIndex],
                        ),
                      ],
                    );
                  },
                ),
                if (state.isLoadMore)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      BoxSimmer(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: 200,
                      ),
                      BoxSimmer(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: 200,
                      ),
                    ],
                  )
              ],
            ),
          ]);
        }

        if (state is LocationError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class LocationCard extends StatelessWidget {
  final Location location;
  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to location detail
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    location.name,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    location.dimension,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    location.type,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
