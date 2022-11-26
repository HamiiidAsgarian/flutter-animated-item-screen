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
  final String? brandLogo;

  Shoe({
    this.id,
    this.title,
    this.category,
    this.sizes,
    this.colors,
    this.price,
    this.imageUrl,
    this.brandName,
    this.brandLogo,
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
        brandLogo: map['brandLogo'] as String);
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
  //     'brandLogo': brandLogo,
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
  //     map['brandLogo'] as String
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ShoeClass.fromJson(String source) =>
  //     ShoeClass.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ShoeClass(colors: $colors, sizes: $sizes, price: $price, title: $title, category: $category, imageUrl: $imageUrl, brandName: $brandName, brandLogo: $brandLogo)';
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
  //       other.brandLogo == brandLogo;
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
  //       brandLogo.hashCode;
  // }
}

List<Map<String, dynamic>> products = [
  {
    "id": 1,
    "title": "sadasd",
    "category": "asdasd",
    "sizes": [1, 2, 5, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "asdasd",
    "imageUrl": "asdasda",
    "brandLogo": "asdasdas"
  },
  {
    "id": 1,
    "title": "sadasd",
    "category": "asdasd",
    "sizes": [1, 2, 5, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "asdasd",
    "imageUrl": "asdasda",
    "brandLogo": "asdasdas"
  },
  {
    "id": 1,
    "title": "sadasd",
    "category": "asdasd",
    "sizes": [1, 2, 5, 6],
    "colors": ["red", "green", "blue"],
    "price": 54545.0,
    "brandName": "asdasd",
    "imageUrl": "asdasda",
    "brandLogo": "asdasdas"
  }
];
