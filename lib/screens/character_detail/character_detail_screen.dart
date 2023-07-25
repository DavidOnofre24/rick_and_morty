import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/screens/character_detail/cubit/character_detail_cubit.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
        bloc: context.read<CharacterDetailCubit>(),
        builder: (context, state) {
          if (state is CharacterDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CharacterDetailError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (state is CharacterDetailLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  Center(
                    child: Text(state.characterDetail.name),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
