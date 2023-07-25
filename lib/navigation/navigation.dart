import 'package:flutter/material.dart';

abstract class RouteBuilder {
  final BuildContext context;
  final bool rootNavigator;

  RouteBuilder({
    required this.context,
    this.rootNavigator = false,
  });

  Route getRoute();

  Future<void> push() async {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).push(getRoute());
  }

  Future<void> pushAndRemoveAll() async {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushAndRemoveUntil(getRoute(), (route) => false);
  }

  Future<void> pushAndRemoveUntilNamed(String name) async {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushAndRemoveUntil(getRoute(), (route) => route.settings.name == name);
  }

  Future<void> pushReplacement() async {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushReplacement(getRoute());
  }
}
