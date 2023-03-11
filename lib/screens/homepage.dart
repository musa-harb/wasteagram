import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post.dart';
import 'package:wasteagram/widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  static const screenName = 'Wasteagram';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  File? image;
  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    if (!context.mounted) return;
    Navigator.pushNamed(context, NewPost.routeName, arguments: image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
        screenName: HomePage.screenName,
        screen: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
