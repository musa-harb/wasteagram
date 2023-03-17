import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import '../widgets/app_scaffold.dart';
import '../models/post.dart';

class PostDetails extends StatelessWidget {
  static const routeName = 'details';
  static const screenName = 'Wasteagram';
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Post postDetails = ModalRoute.of(context)?.settings.arguments as Post;
    return AppScaffold(
        screenName: screenName,
        screen: Center(
          child: Column(            
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 36.0),
                child: Text(formateDateTime(postDetails.postDate),
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Expanded(
                child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage, image: postDetails.postURL),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: Text('${postDetails.wasteQty.toString()} items',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 36.0),
                child: Text(
                    'Location: (${postDetails.latitude}, ${postDetails.longitude})'),
              )
            ],
          ),
        ));
  }

  String formateDateTime(DateTime postDate) {
    return DateFormat.yMMMEd().format(postDate).toString();
  }
}
