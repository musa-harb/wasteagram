import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class NewPost extends StatefulWidget {
  static const routeName = 'new';
  static const screenName = 'New Post';
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final File image = ModalRoute.of(context)?.settings.arguments as File;
    print(image);
    return AppScaffold(
        screenName: NewPost.screenName,
        screen: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.file(image)),
          Expanded(child: numberOfWaste()),          
          saveButton(context),
        ],
        )
    );
  }

  Widget numberOfWaste() {
    return Form(
      key: formKey,
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: true,
        onSaved: (value) {},
        validator: (value) =>
            value!.isEmpty ? 'Please enter number of Waste' : null,
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            print('Saving.....!');
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.cloud_upload));
  }
}
