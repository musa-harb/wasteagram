  import 'dart:io';
  import 'package:image_picker/image_picker.dart';
  
  File? image;
  final picker = ImagePicker();
  
  
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    }
  }