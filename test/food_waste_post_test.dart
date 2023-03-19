import 'package:test/test.dart';
import '../lib/models/food_waste_post.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    const date = '2023-03-22';
    const url = 'www.google.com';
    const quantity = 7;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost.fromMap({
      'date': date,
      'imageURL': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
    });

    expect(foodWastePost.postDate, DateTime.parse(date));
    expect(foodWastePost.imageURL, url);
  });
}
