// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Shoe {
  final int? id;
  final List<Color>? colors;
  final List<double>? sizes;
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
        case "pink":
          res = Colors.pinkAccent;
          break;
        case "black":
          res = Colors.black;
          break;
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
  final double selectedSize;
  final Shoe shoe;

  SelectedShoe(
      {required this.selectedColor,
      required this.selectedSize,
      required this.shoe});

  factory SelectedShoe.fromShoe(
      Shoe shoe, Color selectedColor, double selectedSize) {
    return SelectedShoe(
        shoe: shoe, selectedColor: selectedColor, selectedSize: selectedSize);
  }
}

List<Map<String, dynamic>> products = [
  {
    "id": 1,
    "title": "Nike Air Max 270",
    "category": "Sport",
    "sizes": [5, 5.5, 6, 7],
    "colors": ["red", "green", "blue"],
    "price": 1200.50,
    "brandName": "Nike",
    "imageUrl": "assets/images/shoes/n1.png",
    "LogoUrl": "assets/images/logos/nikeLogo.png"
  },
  {
    "id": 2,
    "title": "Flexagon Force 4",
    "category": "Footwear Women",
    "sizes": [5.5, 6],
    "colors": ["pink", "green"],
    "price": 90.00,
    "brandName": "Rebook",
    "imageUrl": "assets/images/shoes/r1.png",
    "LogoUrl": "assets/images/logos/rebookLogo.png"
  },
  {
    "id": 3,
    "title": "Enzo Sport IMEVA-MAHSA",
    "category": "Men's Running",
    "sizes": [5.5, 6, 7.5],
    "colors": ["black", "green", "blue", "red"],
    "price": 1401.22,
    "brandName": "Puma",
    "imageUrl": "assets/images/shoes/p1.png",
    "LogoUrl": "assets/images/logos/pumaLogo.png"
  }
];
