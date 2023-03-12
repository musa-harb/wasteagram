import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/app_scaffold.dart';
import '../models/post.dart';

class PostDetails extends StatelessWidget {
  static const routeName = 'details';
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Post postDetails = ModalRoute.of(context)?.settings.arguments as Post;
    print(postDetails.latitude);
    return AppScaffold(
        screenName: 'Wasteagram',
        screen: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(formateDateTime(postDetails.postDate)),
              Expanded(child: Image.network(postDetails.postURL)),
              Text(postDetails.wasteQty.toString()),
              Text('Location: (${postDetails.latitude}, ${postDetails.longitude})')
            ],
          ),
        ));
  }

  String formateDateTime(DateTime postDate) {
    return DateFormat.yMMMEd().format(postDate).toString();
  }
}
