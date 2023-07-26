import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/screens/episodes/cubit/episodes_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';
import 'package:rick_and_morty_app/screens/widgets/row_description.dart';
import 'package:rick_and_morty_app/screens/widgets/search_widget.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final scrollController = ScrollController();
  int selectFilter = 0;

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      final state = context.read<EpisodesCubit>().state as EpisodesLoaded;
      if (state.isSearch) {
        context.read<EpisodesCubit>().searchEpisode();
      } else {
        context.read<EpisodesCubit>().fetchEpisodies();
      }
    }
  }

  @override
  void initState() {
    context.read<EpisodesCubit>().fetchEpisodies();
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
            _buildEpisodesCards(context),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder<EpisodesCubit, EpisodesState> _buildEpisodesCards(
      BuildContext context) {
    return BlocBuilder<EpisodesCubit, EpisodesState>(
      bloc: context.read<EpisodesCubit>(),
      builder: (context, state) {
        if (state is EpisodesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is EpisodesLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeCard(
                    episode: state.episodes[index],
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
          );
        }

        if (state is EpisodesError) {
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
              child: const Text('By Episode'),
            ),
          ],
        ),
        SearchWidget(onSearch: (value) {
          selectFilter == 0
              ? context.read<EpisodesCubit>().setName(value)
              : context.read<EpisodesCubit>().setEpisode(value);
        }),
      ],
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => EpisodeDetailModal(
            episode: episode,
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
                  episode.name,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  episode.episode,
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

class EpisodeDetailModal extends StatelessWidget {
  final Episode episode;
  const EpisodeDetailModal({
    super.key,
    required this.episode,
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
                episode.name,
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
              description: episode.id.toString(),
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Episode',
              description: episode.episode,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Created',
              description: DateFormat('MM/dd/yyyy').format(episode.created),
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            RowDescription(
              mainAxisAlignment: MainAxisAlignment.start,
              label: 'Air date',
              description: episode.airDate,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
