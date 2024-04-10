
import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  final String title;
  final double price;
  final String pictureUrl;
  final String category;
  final List<String> ingredients;

  Dish({
    required this.title,
    required this.price,
    required this.pictureUrl,
    required this.ingredients,
    required this.category
  });

  factory Dish.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Dish(
      title: data['title'],
      price: data['price'],
      category: data['category'],
      pictureUrl: data['pictureUrl'] ?? "",
      ingredients: List<String>.from(data['ingredients']),
    );
  }
}