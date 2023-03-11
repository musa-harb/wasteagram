import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

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
        ));
  }

  Widget numberOfWaste() {
    return Form(
      key: formKey,
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: true,
        onSaved: (value) {
          saveToDataBase(int.parse(value as String));
        },
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

  void saveToDataBase(int wasteQty) {
    FirebaseFirestore.instance.collection('posts').add({
      'date': DateTime.now().toString(),
      'imageURL': 'google.com',
      'latitude': locationData!.latitude,
      'longitude': locationData!.longitude,
      'quantity': wasteQty
    });
  }

  void retrieveLocation() async {
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
}
