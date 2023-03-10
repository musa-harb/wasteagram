import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  static const screenName = 'Wasteagram';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
        screenName: screenName,
        screen: Center(child: CircularProgressIndicator()));
  }
}
