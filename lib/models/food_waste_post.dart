class FoodWastePost {
  final DateTime postDate;
  final String imageURL;
  final double latitude;
  final double longitude;
  final int wasteQty;

  const FoodWastePost(
      {required this.postDate,
      required this.imageURL,
      required this.latitude,
      required this.longitude,
      required this.wasteQty});

  factory FoodWastePost.fromMap(Map<dynamic, dynamic> postDetails) {
    return FoodWastePost(
      postDate: DateTime.parse(postDetails['date']),
      imageURL: postDetails['imageURL'],
      latitude: postDetails['latitude'],
      longitude: postDetails['longitude'],
      wasteQty: postDetails['quantity'],
    );
  }
}
