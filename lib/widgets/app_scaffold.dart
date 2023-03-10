import 'package:flutter/material.dart';
import '../screens/new_post.dart';

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
          leading: screenName == 'New Post' ? BackButton() : null,
        ),
        body: screen,
        floatingActionButton: screenName == 'Wasteagram'
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, NewPost.routeName);
                },
                child: const Icon(Icons.camera_alt),
              )
            : null);
  }
}
