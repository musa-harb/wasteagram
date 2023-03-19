import 'package:flutter/material.dart';
import '../screens/new_post.dart';
import '../screens/post_details.dart';
import '../services/post_camera.dart';

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
        floatingActionButton:
            checkScreenName(screenName) ? cameraFab(context) : null);
  }

  bool checkScreenName(String screenName) {
    return (screenName != NewPost.screenName &&
        screenName != PostDetails.screenName);
  }

  Widget cameraFab(BuildContext context) {
    return Semantics(
      enabled: true,
      onTapHint: 'Take a picture of food waste',
      child: FloatingActionButton(
        onPressed: () async {
          final image = await getImage();
          if (image != null) {
            Navigator.pushNamed(context, NewPost.routeName, arguments: image);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
