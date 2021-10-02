//Import Material Library, Recipe class, NutrientInfo class.
import 'package:flutter/material.dart';

import './nutrient_info.dart';
import './recipe.dart';

class MealPlan {
  /*
  MealPlan class includes a list of recipes, nutrient details, and
  a Future variable indicating whether recipe images have been
  retrieved.
  */

  List<Recipe> _recipes;
  NutrientInfo _nutrients;
  Future _done;

  //Constructor with required named parameters that executes getImages()
  MealPlan({@required List<Recipe> recipes, double calories, double fat, double protein, double carbs}) {
    _recipes = recipes;
    _done = getImages();
    _nutrients = NutrientInfo(
        calories: calories, fat: fat, carbs: carbs, protein: protein);
  }

  //getters
  NutrientInfo get getNutrients => _nutrients;
  List<Recipe> get getRecipes => _recipes;
  //Indicates whether recipe image URLs have been successfully retrieved
  Future get finishedInit => _done;

  /*
  Factory constructor iterates through decoded meal plan data, creates a
  list of recipes, and returns a MealPlan object using necessary information.
  */

  factory MealPlan.fromMap(Map<String, dynamic> parsedData) {
    List<Recipe> recipes = [];
    parsedData['meals'].forEach((element) async {
      Recipe recipe = Recipe.noNutrients(element);
      recipes.add(recipe);
    });

    return MealPlan(
      recipes: recipes,
      calories: parsedData['nutrients']['calories'],
      fat: parsedData['nutrients']['fat'],
      protein: parsedData['nutrients']['protein'],
      carbs: parsedData['nutrients']['carbohydrates'],
    );
  }

  /*
  Calls getImage() for the meal recipes. Use of a forEach loop would 
  cause the return statement to be executed before completion, as the loop
  is a function itself. To avoid the complications of nesting an async function 
  within another async function and since only three recipes will be included in 
  each meal plan, a forEach loop is not used.
  */

  Future<bool> getImages() async {
    for (num index in [0,1,2]) {
      await _recipes[index].retrieveImage();
    }
    return true;
  }
}
