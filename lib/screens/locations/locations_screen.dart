import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty_app/models/location/location_model.dart';
import 'package:rick_and_morty_app/screens/locations/cubit/location_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';
import 'package:rick_and_morty_app/screens/widgets/row_description.dart';
import 'package:rick_and_morty_app/screens/widgets/search_widget.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final scrollController = ScrollController();
  int selectFilter = 0;

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
    return SafeArea(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            _filterSection(context),
            _buildLocationsCard(context),
          ],
        ),
      ),
    );
  }

  BlocBuilder<LocationCubit, LocationState> _buildLocationsCard(
      BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: context.read<LocationCubit>(),
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is LocationLoaded) {
          return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.locations.length,
                      itemBuilder: (context, index) {
                        return LocationCard(
                          location: state.locations[index],
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
                      ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ]);
        }

        if (state is LocationError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Column _filterSection(BuildContext context) {
    return Column(
      children: [
        const Text('Select by filter do you want to search'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (selectFilter == 0) {
                      return Colors.blue;
                    }
                    return Colors.grey[700]!;
                  })),
              onPressed: () {
                setState(() {
                  selectFilter = 0;
                });
              },
              child: const Text('By Name'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (selectFilter == 1) {
                      return Colors.blue;
                    }
                    return Colors.grey[700]!;
                  })),
              onPressed: () {
                setState(() {
                  selectFilter = 1;
                });
              },
              child: const Text('By Type'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (selectFilter == 2) {
                      return Colors.blue;
                    }
                    return Colors.grey[700]!;
                  })),
              onPressed: () {
                setState(() {
                  selectFilter = 2;
                });
              },
              child: const Text('By Dimension'),
            ),
          ],
        ),
        SearchWidget(onSearch: (value) {
          selectFilter == 0
              ? context.read<LocationCubit>().setName(value)
              : selectFilter == 1
                  ? context.read<LocationCubit>().setType(value)
                  : context.read<LocationCubit>().setDimension(value);
        }),
      ],
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
        showDialog(
          context: context,
          builder: (context) => LocationDetailModal(
            location: location,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location.type,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location.dimension,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LocationDetailModal extends StatelessWidget {
  final Location location;
  const LocationDetailModal({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffA0A0A9),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                location.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Id',
              description: location.id.toString(),
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'type',
              description: location.type,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Created',
              description: DateFormat('MM/dd/yyyy').format(location.created),
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Dimension',
              description: location.dimension,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
