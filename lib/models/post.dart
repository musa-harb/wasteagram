import 'dart:ffi';

class Post {
  final DateTime postDate;
  final String postURL;
  final Float latitude;
  final Float longitude;
  final int wasteQty;

  const Post(
      {required this.postDate,
      required this.postURL,
      required this.latitude,
      required this.longitude,
      required this.wasteQty});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      postDate: json['date'],
      postURL: json['url'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      wasteQty: json['wasteQty'],
    );
  }
}
