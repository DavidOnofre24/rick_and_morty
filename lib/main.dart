import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/dependecies_injection/dependencies_injection.dart';
import 'package:rick_and_morty_app/screens/home/home_route.dart';

void main() async {
  await setupDependencies();
  runApp(const MainApp());
}

final mainNavigationKey = GlobalKey<NavigatorState>();

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigationKey,
      debugShowCheckedModeBanner: false,
      title: 'Rick and morty app',
      home: const InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainNavigationKey.currentState
          ?.pushReplacement(HomeRoute(context).getRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
