import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/screens/character_detail/character_detail_route.dart';
import 'package:rick_and_morty_app/screens/characters/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      context.read<CharactersCubit>().fetchCharacters();
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Characters'),
        ),
        body: BlocBuilder<CharactersCubit, CharactersState>(
          bloc: context.read<CharactersCubit>(),
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CharactersLoaded) {
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
                      itemCount: state.characters.length ~/ 2,
                      itemBuilder: (context, index) {
                        int firstIndex = index * 2;
                        int secondIndex = index * 2 + 1;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CharacterCard(
                              character: state.characters[firstIndex],
                            ),
                            CharacterCard(
                              character: state.characters[secondIndex],
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

            if (state is CharactersError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CharacterDetailRoute(context, id: character.id).push();
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => BoxSimmer(
                  width: MediaQuery.of(context).size.width * 0.43,
                ),
                errorWidget: (context, url, error) =>
                    BoxSimmer(width: MediaQuery.of(context).size.width * 0.43),
              ),
            ),
            Text(character.name),
          ],
        ),
      ),
    );
  }
}
