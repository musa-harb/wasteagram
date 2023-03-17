import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
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
        autofocus: true,
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
      child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.cloud_upload)),
    );
  }

  void saveToDataBase(int wasteQty) async {
    await retrieveLocation();
    final url = await storeAndgetImageURL(image!);
    FirebaseFirestore.instance.collection('posts').add({
      'date': DateTime.now().toString(),
      'imageURL': url,
      'latitude': locationData!.latitude,
      'longitude': locationData!.longitude,
      'quantity': wasteQty
    });
  }

  Future retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
  }

  Future storeAndgetImageURL(File image) async {
    final fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    return await storageReference.getDownloadURL();
  }
}
