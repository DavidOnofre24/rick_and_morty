import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/models/character/character_model.dart';
import 'package:rick_and_morty_app/models/character/gender_enum.dart';
import 'package:rick_and_morty_app/models/character/species_enum.dart';
import 'package:rick_and_morty_app/models/character/status_enum.dart';
import 'package:rick_and_morty_app/screens/character_detail/character_detail_route.dart';
import 'package:rick_and_morty_app/screens/characters/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/screens/widgets/box_shimmer.dart';
import 'package:rick_and_morty_app/screens/widgets/search_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final scrollController = ScrollController();
  int selectStatusFilter = -1;
  int selectGenderFilter = -1;
  int selectSpeciesFilter = -1;

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      final state = context.read<CharactersCubit>().state as CharactersLoaded;
      if (state.isSearch) {
        context.read<CharactersCubit>().searchCharacter();
      } else {
        context.read<CharactersCubit>().fetchCharacters();
      }
    }
  }

  @override
  void initState() {
    context.read<CharactersCubit>().fetchCharacters();
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
            SearchWidget(onSearch: context.read<CharactersCubit>().setName),
            const Text('Filter by status'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectStatusFilter == 0) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectStatusFilter = 0;
                      context
                          .read<CharactersCubit>()
                          .setStatus(Status.alive.name);
                    });
                  },
                  child: const Text('By Alive'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectStatusFilter == 1) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectStatusFilter = 1;
                      context
                          .read<CharactersCubit>()
                          .setStatus(Status.dead.name);
                    });
                  },
                  child: const Text('By Dead'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectStatusFilter == 2) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectStatusFilter = 2;
                      context
                          .read<CharactersCubit>()
                          .setStatus(Status.unknown.name);
                    });
                  },
                  child: const Text('By Unknown'),
                ),
              ],
            ),
            const Text('Filter by gender'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectGenderFilter == 0) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectGenderFilter = 0;
                      context
                          .read<CharactersCubit>()
                          .setGender(Gender.male.name);
                    });
                  },
                  child: const Text('By Male'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectGenderFilter == 1) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectGenderFilter = 1;
                      context
                          .read<CharactersCubit>()
                          .setGender(Gender.female.name);
                    });
                  },
                  child: const Text('By Female'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectGenderFilter == 2) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectGenderFilter = 2;
                      context
                          .read<CharactersCubit>()
                          .setGender(Gender.unknown.name);
                    });
                  },
                  child: const Text('By Unknown'),
                ),
              ],
            ),
            const Text('Filter by species'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectSpeciesFilter == 0) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectSpeciesFilter = 0;
                      context
                          .read<CharactersCubit>()
                          .setSpecies(Species.human.name);
                    });
                  },
                  child: const Text('By Human'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (selectSpeciesFilter == 1) {
                          return Colors.blue;
                        }
                        return Colors.grey[700]!;
                      })),
                  onPressed: () {
                    setState(() {
                      selectSpeciesFilter = 1;
                      context
                          .read<CharactersCubit>()
                          .setSpecies(Species.alien.name);
                    });
                  },
                  child: const Text('By Alien'),
                ),
              ],
            ),
            BlocBuilder<CharactersCubit, CharactersState>(
              bloc: context.read<CharactersCubit>(),
              builder: (context, state) {
                if (state is CharactersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CharactersLoaded) {
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
                              itemCount: (state.characters.length == 1)
                                  ? state.characters.length
                                  : state.characters.length ~/ 2,
                              itemBuilder: (context, index) {
                                int firstIndex = index;
                                int secondIndex = index * 2 + 1;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CharacterCard(
                                      character: state.characters[firstIndex],
                                    ),
                                    if (state.characters.length != 1)
                                      CharacterCard(
                                        character:
                                            state.characters[secondIndex],
                                      ),
                                  ],
                                );
                              },
                            ),
                            if (state.isLoadMore)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BoxSimmer(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    height: 200,
                                  ),
                                  BoxSimmer(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    height: 200,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ]);
                }

                if (state is CharactersError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(state.message),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CharactersCubit>().fetchCharacters();
                        },
                        child: const Text("Reload"),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
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
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: character.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => BoxSimmer(
                      width: MediaQuery.of(context).size.width * 0.43,
                    ),
                    errorWidget: (context, url, error) => BoxSimmer(
                        width: MediaQuery.of(context).size.width * 0.43),
                  ),
                  Positioned(
                      child: Container(
                    margin: const EdgeInsets.only(left: 5, top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: (character.status.name == 'alive')
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      character.status.name.substring(0, 1).toUpperCase() +
                          character.status.name.substring(1),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                character.name,
                maxLines: 1,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
