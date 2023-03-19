import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import '../widgets/app_scaffold.dart';
import '../services/post_location.dart';

class NewPost extends StatefulWidget {
  static const routeName = 'new';
  static const screenName = 'New Post';
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();
  LocationData? locationData;
  var locationService = Location();
  File? image;


  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments as File;
    return AppScaffold(
        screenName: NewPost.screenName,
        screen: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.file(image!)),
            Expanded(child: enterNumberOfWaste()),
            saveButton(context),
          ],
        ));
  }

  Widget enterNumberOfWaste() {
    return Form(
      key: formKey,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: "Number of Wasted Items",
        ),
        style: Theme.of(context).textTheme.headlineMedium,
        onSaved: (value) {
          saveToDataBase(int.parse(value as String));
        },
        validator: (value) =>
            value!.isEmpty ? 'Please enter number of Waste' : null,
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Semantics(
        label: 'Save button to save the new waste post to the database',
        enabled: true,
        onTapHint: 'Tab to save the food waste post',
        child: ElevatedButton(
            onPressed: () async {
              locationData = await retrievePostLocation();
              if (locationData == null) {
                locationPermissionDialog(context);
              } else if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.cloud_upload)),
      ),
    );
  }

  void locationPermissionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Location Service Not Permitted'),
              content:
                  const Text('Please enable location services and try again'),
              actions: [
                TextButton(
                  child: const Text('OK!'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void saveToDataBase(int wasteQty) async {
    final url = await storeAndgetImageURL(image!);
    FirebaseFirestore.instance.collection('posts').add({
      'date': DateTime.now().toString(),
      'imageURL': url,
      'latitude': locationData!.latitude,
      'longitude': locationData!.longitude,
      'quantity': wasteQty
    });
  }

  Future storeAndgetImageURL(File image) async {
    final fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    return await storageReference.getDownloadURL();
  }
}
