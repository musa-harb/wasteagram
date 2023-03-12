import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        screenName: HomePage.screenName,
        screen: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var post = snapshot.data!.docs[index];                              
                              return listTileWidget(
                                  post['date'], post['quantity']);
                            }))
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget listTileWidget(String date, int qty) {
    return ListTile(
      leading: Text(formateDate(date)),
      trailing: Text(
        qty.toString(),
      ),
      dense: true,
    );
  }

  String formateDate(String dateTime) {
    final postDateTime = DateTime.parse(dateTime);
    final day = DateFormat.EEEE().format(postDateTime).toString();
    final month = DateFormat.yMMMMd().format(postDateTime).toString();
    final modifiedDateTime = '$day, $month';
    return modifiedDateTime;
  }
}
