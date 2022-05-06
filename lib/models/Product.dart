import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/converse1.png",
      "assets/images/converse2.png",
      "assets/images/converse3.png",
      "assets/images/converse4.png",
    ],
    title: "Run Star Motion CX Platform Canvas",
    price: 140,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike W Dunk Low",
    price: 125,
    description: description,
    rating: 4.9,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    title: "adidas Trae Young 1",
    price: 120,
    description: description,
    rating: 4.4,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/puma1.png",
    ],
    title: "Puma Mayze Flutur Dua Lipa",
    price: 135,
    description: description,
    rating: 4.7,
    isFavourite: true,
  ),
];

const String description = "Yuru yuregim, gidelim buralardan ask bizimle degil";
