import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './nutrient_info.dart';
import './meal_option.dart';

class Product extends MealOption {
  
  Future _done;

  Product({
    @required int id,
    @required String title,
    @required String image,
  }) : super(id: id, title: title, image: image, source: '') {
    _done = retrieveNutrients();
  }

  Future get finishedInit => _done;

  factory Product.fromMap(Map<String, dynamic> parsedData) {
    return Product(
      id: parsedData['id'],
      title: parsedData['title'],
      image: parsedData['image'],
    );
  }

  Future<bool> retrieveNutrients() async {
    try {
      String url =
          "https://api.spoonacular.com/food/products/$id?apiKey=5fcc574d7b9843398dfa0258dbda3d86";

      var response = await http.get(url);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      nutrients = NutrientInfo.fromMap(jsonData['nutrition']);
      return true;
    } catch (error) {
      throw error.toString();
    }
  }
}