import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'post_details.dart';
import '../widgets/app_scaffold.dart';
import '../models/post.dart';

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
  Post? postDetail;
  int? totalWaste;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    return image;
  }

  @override
  void initState() {
    super.initState();
    totalWaste = 0;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    return AppScaffold(
        screenName: '${HomePage.screenName} - $totalWaste',
        screen: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              var tempTotalWaste = 0;
              print('tempTotalWaste $tempTotalWaste');
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var post = snapshot.data!.docs[index];

                              tempTotalWaste += post['quantity'] as int;
                              if (totalWaste! < tempTotalWaste &&
                                  index == snapshot.data!.docs.length - 1) {
                                totalWaste = tempTotalWaste;
                              }
                              print('total waste: $totalWaste');
                              print(tempTotalWaste);

                              return GestureDetector(
                                child: listTileWidget(
                                    post['date'], post['quantity']),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PostDetails.routeName,
                                      arguments: Post.fromMap(post.data()));
                                },
                              );
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

  void updateTotalWaste() {}
}
