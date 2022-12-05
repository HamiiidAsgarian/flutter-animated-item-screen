// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Shoe {
  final int? id;
  final List<Color>? colors;
  final List<int>? sizes;
  final double? price;
  final String? title;
  final String? category;
  final String? imageUrl;
  final String? brandName;
  final String? logoUrl;

  Shoe({
    this.id,
    this.title,
    this.category,
    this.sizes,
    this.colors,
    this.price,
    this.imageUrl,
    this.brandName,
    this.logoUrl,
  });
  factory Shoe.fromMap(Map<String, dynamic> map) {
    List<Color> colors = (map['colors'] as List<String>).map((e) {
      late Color res;
      switch (e) {
        case "green":
          res = Colors.greenAccent;
          break;
        case "red":
          res = Colors.redAccent;
          break;
        case "blue":
          res = Colors.blueAccent;
          break;
        case "yellow":
          res = Colors.yellowAccent;
          break;
        default:
          {
            res = Colors.grey;
          }
      }
      return res;
    }).toList();

    return Shoe(
        id: map['id'],
        colors: colors,
        // colors: List.from((map['colors'] as List)),
        sizes: List.from((map['sizes'] as List)),
        price: map['price'] as double,
        title: map['title'] as String,
        category: map['category'] as String,
        imageUrl: map['imageUrl'] as String,
        brandName: map['brandName'] as String,
        logoUrl: map['LogoUrl'] as String);
  }
}

class SelectedShoe extends Shoe {
  final Color selectedColor;
  final int selectedSize;
  final Shoe shoe;

  SelectedShoe(
      {required this.selectedColor,
      required this.selectedSize,
      required this.shoe});

  factory SelectedShoe.fromShoe(
      Shoe shoe, Color selectedColor, int selectedSize) {
    return SelectedShoe(
        shoe: shoe, selectedColor: selectedColor, selectedSize: selectedSize);
  }
}

List<Map<String, dynamic>> products = [
  {
    "id": 1,
    "title": "Nike Air Max 270",
    "category": "Running",
    "sizes": [32, 33, 34, 42],
    "colors": ["red", "green", "blue"],
    "price": 1200.0,
    "brandName": "Nike",
    "imageUrl": "assets/images/shoes/n3.png",
    "LogoUrl": "assets/images/logos/nikeLogo.png"
  },
  {
    "id": 2,
    "title": "Puma Runner",
    "category": "Football",
    "sizes": [41, 42],
    "colors": ["green", "yellow"],
    "price": 800.0,
    "brandName": "Puma",
    "imageUrl": "assets/images/shoes/r1.png",
    "LogoUrl": "assets/images/logos/pumaLogo.png"
  },
  {
    "id": 3,
    "title": "Ancestor 2011",
    "category": "Sport",
    "sizes": [39, 41, 42],
    "colors": ["yellow", "green", "blue", "red"],
    "price": 1399.9,
    "brandName": "Rebook",
    "imageUrl": "assets/images/shoes/p1.png",
    "LogoUrl": "assets/images/logos/rebookLogo.png"
  }
];
