import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class Product {
  final String ID;
  final String name, brand, description, distributor, warrantyStatus, price;
  final double rating;
  final bool isPopular;
  var sizesStocks = [];
  var comments = [];
  var pictureURLs = [];

  Product({
    required this.ID,
    required this.pictureURLs,
    this.rating = 0.0,
    this.isPopular = false,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.comments,
    required this.sizesStocks,
    required this.distributor,
    required this.warrantyStatus
  });
}

// Our demo Products

List<Product> demoProducts = [
  /*Product(
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
  ),*/
];

List<String> favProducts = [];

const String description = "Yuru yuregim, gidelim buralardan ask bizimle degil";
