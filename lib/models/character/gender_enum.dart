import 'package:rick_and_morty_app/models/enum_values.dart';

enum Gender { male, female, unknown }

final genderValues = EnumValues({
  "Female": Gender.female,
  "Male": Gender.male,
  "unknown": Gender.unknown,
});
