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
  var totalWaste = 0;
  var tempTotalWaste = 0;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      image = File(pickedFile.path);    
      return image;
    }    
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        screenName: '${HomePage.screenName} - $totalWaste',
        screen: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              tempTotalWaste = 0;
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (totalWaste != 0) {
                    resetTotalWaste();
                  }
                });
                return const Center(child: Text('No wastes posts recorded!'));
              }

              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              updateTotalWaste();
                            });

                            Post post =
                                Post.fromMap(snapshot.data!.docs[index].data());

                            tempTotalWaste = tempTotalWaste + post.wasteQty;

                            return GestureDetector(
                              child:
                                  listTileWidget(post.postDate, post.wasteQty),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PostDetails.routeName,
                                    arguments: post);
                              },
                            );
                          }))
                ],
              );
            }));
  }

  Widget listTileWidget(DateTime date, int qty) {
    return ListTile(
      leading: Text(formateDate(date)),
      trailing: Text(qty.toString()),
      dense: true,
    );
  }

  String formateDate(DateTime dateTime) {
    final day = DateFormat.EEEE().format(dateTime).toString();
    final month = DateFormat.yMMMMd().format(dateTime).toString();
    final modifiedDateTime = '$day, $month';
    return modifiedDateTime;
  }

  void incrementTotalWaste() {}

  void updateTotalWaste() {
    if (totalWaste != tempTotalWaste) {
      totalWaste = tempTotalWaste;
      setState(() {});
    }
  }

  void resetTotalWaste() {
    totalWaste = 0;
    setState(() {});
  }
}
