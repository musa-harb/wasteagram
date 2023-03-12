import 'package:flutter/material.dart';
import '../screens/homepage.dart';
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
        ),
        resizeToAvoidBottomInset: false,
        body: screen,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: screenName == 'Wasteagram'
            ? FloatingActionButton(
                onPressed: () async {
                  HomePageState homePageState =
                      context.findAncestorStateOfType<HomePageState>()
                          as HomePageState;
                  final image = await homePageState.getImage();
                  Navigator.pushNamed(context, NewPost.routeName, arguments: image);
                },
                child: const Icon(Icons.camera_alt),
              )
            : null);
  }
}
