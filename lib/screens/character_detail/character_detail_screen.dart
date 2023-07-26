import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character/character_detail_model.dart';
import 'package:rick_and_morty_app/screens/character_detail/cubit/character_detail_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';
import 'package:rick_and_morty_app/screens/widgets/row_description.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      bloc: context.read<CharacterDetailCubit>(),
      builder: (context, state) {
        if (state is CharacterDetailLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is CharacterDetailError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (state is CharacterDetailLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                _appBar(state.characterDetail),
                SliverList(
                    delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]),
                    child: Column(
                      children: [
                        RowDescription(
                          label: "Status",
                          description: state.characterDetail.status,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RowDescription(
                          label: "Species",
                          description: state.characterDetail.species,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RowDescription(
                          label: "Type",
                          description: state.characterDetail.type,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RowDescription(
                          label: "Gender",
                          description: state.characterDetail.gender,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RowDescription(
                          label: "Orgin",
                          description: state.characterDetail.origin.name,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RowDescription(
                          label: "Location",
                          description: state.characterDetail.location.name,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      "Episodes where you can see",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        width: 10,
                      ),
                      for (var episode in state.characterDetail.episode)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ]),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            "Episode: ${episode.split('/').last} ",
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
                  ),
                ])),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _appBar(CharacterDetail characterDetail) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            characterDetail.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        background: CachedNetworkImage(
          imageUrl: characterDetail.image,
          placeholder: (context, url) => const BoxSimmer(
            width: double.infinity,
            height: 250,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
