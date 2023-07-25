import 'package:rick_and_morty_app/models/enum_values.dart';

enum Species { human, alien, unknown }

final speciesValues = EnumValues({
  "Alien": Species.alien,
  "Human": Species.human,
  "unknown": Species.unknown,
});
