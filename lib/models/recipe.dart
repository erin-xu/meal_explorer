import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './nutrient_info.dart';
import './meal_option.dart';

class Recipe extends MealOption {
  
  Recipe({
    @required id,
    @required String title,
    @required String image,
    @required String source,
    NutrientInfo nutrients, //only recipes from search results need nutrient details
  }) : super(
            id: id,
            title: title,
            image: image,
            source: source,
            nutrients: nutrients);

  factory Recipe.withNutrients(Map<String, dynamic> parsedData) {
    return Recipe(
      id: parsedData['id'],
      title: parsedData['title'],
      image: parsedData['image'],
      source: parsedData['sourceUrl'],
      nutrients: NutrientInfo.fromMap(parsedData['nutrition']),
    );
  }

  factory Recipe.noNutrients(Map<String, dynamic> parsedData) {
    return Recipe(
      id: parsedData['id'],
      title: parsedData['title'],
      image: parsedData['image'],
      source: parsedData['sourceUrl'],
    );
  }

  Future<bool> retrieveImage() async {
    try {
      String url =
          "https://api.spoonacular.com/recipes/$id/information?apiKey=5fcc574d7b9843398dfa0258dbda3d86";

      var response = await http.get(url);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      image = jsonData['image'];
      return true;
    } catch (error) {
      throw error.toString();
    }
  }
}