import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/episodes/episode_model.dart';
import 'package:rick_and_morty_app/screens/episode_detail/episode_detail_route.dart';
import 'package:rick_and_morty_app/screens/episodes/cubit/episodes_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      context.read<EpisodesCubit>().fetchEpisodies();
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
    return BlocBuilder<EpisodesCubit, EpisodesState>(
      bloc: context.read<EpisodesCubit>(),
      builder: (context, state) {
        if (state is EpisodesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is EpisodesLoaded) {
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
            ),
          ]);
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
}

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        EpisodeDetailRoute(context, episode: episode).push();
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
