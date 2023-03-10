import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class NewPost extends StatelessWidget {
  static const routeName = 'new';
  static const screenName = 'New Post';
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
        screenName: screenName,
        screen: Center(child: CircularProgressIndicator()));
  }
}
