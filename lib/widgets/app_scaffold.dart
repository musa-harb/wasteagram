import 'package:flutter/material.dart';
import '../screens/homepage.dart';

class AppScaffold extends StatelessWidget {
  final String screenName;
  final Widget screen;

  const AppScaffold({
    Key? key,
    required this.screenName,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(screenName),
          centerTitle: true,
          leading: screenName == 'New Post' ? const BackButton() : null,
        ),
        resizeToAvoidBottomInset: false,
        body: screen,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: screenName == 'Wasteagram'
            ? FloatingActionButton(
                onPressed: () {
                  HomePageState homePageState =
                      context.findAncestorStateOfType<HomePageState>()
                          as HomePageState;
                  homePageState.getImage();
                },
                child: const Icon(Icons.camera_alt),
              )
            : null);
  }
}
