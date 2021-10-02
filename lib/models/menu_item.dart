import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './nutrient_info.dart';
import './meal_option.dart';

class MenuItem extends MealOption {
  
  Future _done;

  MenuItem({
    @required int id,
    @required String title,
    @required String image,
    String restaurant, //to include in title
  }) : super(id: id, title: '$restaurant: $title', image: image, source: '') {
    _done = retrieveNutrients();
  }

  Future get finishedInit => _done;

  factory MenuItem.fromMap(Map<String, dynamic> parsedData) {
    return MenuItem(
      id: parsedData['id'],
      title: parsedData['title'],
      restaurant: parsedData['restaurantChain'],
      image: parsedData['image'],
    );
  }

  Future<bool> retrieveNutrients() async {
    try {
      String url =
          "https://api.spoonacular.com/food/menuItems/$id?apiKey=5fcc574d7b9843398dfa0258dbda3d86";
      var response = await http.get(url);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      nutrients = NutrientInfo.fromMap(jsonData['nutrition']);
      return true;
    } catch (error) {
      throw error.toString();
    }
  }
}