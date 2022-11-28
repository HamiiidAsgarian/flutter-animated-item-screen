// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Shoe {
  final int? id;
  final List? colors;
  final List? sizes;
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
    return Shoe(
        id: map['id'],
        colors: List.from((map['colors'] as List)),
        sizes: List.from((map['sizes'] as List)),
        price: map['price'] as double,
        title: map['title'] as String,
        category: map['category'] as String,
        imageUrl: map['imageUrl'] as String,
        brandName: map['brandName'] as String,
        logoUrl: map['LogoUrl'] as String);
  }
  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'colors': colors,
  //     'sizes': sizes,
  //     'price': price,
  //     'title': title,
  //     'category': category,
  //     'imageUrl': imageUrl,
  //     'brandName': brandName,
  //     'LogoUrl': LogoUrl,
  //   };
  // }

  // factory ShoeClass.fromMap(Map<String, dynamic> map) {
  //   return ShoeClass(
  //     List.from((map['colors'] as List),
  //     List.from((map['sizes'] as List),
  //     map['price'] as double,
  //     map['title'] as String,
  //     map['category'] as String,
  //     map['imageUrl'] as String,
  //     map['brandName'] as String,
  //     map['LogoUrl'] as String
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ShoeClass.fromJson(String source) =>
  //     ShoeClass.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ShoeClass(colors: $colors, sizes: $sizes, price: $price, title: $title, category: $category, imageUrl: $imageUrl, brandName: $brandName, LogoUrl: $LogoUrl)';
  // }

  // @override
  // bool operator ==(covariant ShoeClass other) {
  //   if (identical(this, other)) return true;

  //   return listEquals(other.colors, colors) &&
  //       listEquals(other.sizes, sizes) &&
  //       other.price == price &&
  //       other.title == title &&
  //       other.category == category &&
  //       other.imageUrl == imageUrl &&
  //       other.brandName == brandName &&
  //       other.LogoUrl == LogoUrl;
  // }

  // @override
  // int get hashCode {
  //   return colors.hashCode ^
  //       sizes.hashCode ^
  //       price.hashCode ^
  //       title.hashCode ^
  //       category.hashCode ^
  //       imageUrl.hashCode ^
  //       brandName.hashCode ^
  //       LogoUrl.hashCode;
  // }
}

List<Map<String, dynamic>> products = [
  {
    "id": 1,
    "title": "sh1",
    "category": "asdasd",
    "sizes": [1, 2, 5, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "Nike",
    "imageUrl": "assets/images/shoes/n1.png",
    "LogoUrl": "assets/images/logos/nikeLogo.png"
  },
  {
    "id": 2,
    "title": "sh2",
    "category": "asdasd",
    "sizes": [0, 9, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "Puma",
    "imageUrl": "assets/images/shoes/r1.png",
    "LogoUrl": "assets/images/logos/pumaLogo.png"
  },
  {
    "id": 3,
    "title": "sh3",
    "category": "asdasd",
    "sizes": [9, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "Rebook",
    "imageUrl": "assets/images/shoes/p1.png",
    "LogoUrl": "assets/images/logos/rebookLogo.png"
  }
];
