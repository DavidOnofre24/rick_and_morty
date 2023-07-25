import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/characters_cubit.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CharactersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
