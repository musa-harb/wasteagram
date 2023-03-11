import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/app_scaffold.dart';

class NewPost extends StatelessWidget {
  static const routeName = 'new';
  static const screenName = 'New Post';
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        screenName: screenName,
        screen: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(child: Placeholder()),
            Expanded(child: Placeholder())
          ],
    ));
  }
}
