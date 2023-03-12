class Post {
  final DateTime postDate;
  final String postURL;
  final double latitude;
  final double longitude;
  final int wasteQty;

  const Post(
      {required this.postDate,
      required this.postURL,
      required this.latitude,
      required this.longitude,
      required this.wasteQty});

  factory Post.fromMap(Map<dynamic, dynamic> postDetails) {
    return Post(
      postDate: DateTime.parse(postDetails['date']),
      postURL: postDetails['imageURL'],
      latitude: postDetails['latitude'],
      longitude: postDetails['longitude'],
      wasteQty: postDetails['quantity'],
    );
  }
}
