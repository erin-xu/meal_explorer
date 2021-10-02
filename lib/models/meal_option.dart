import 'package:flutter/material.dart';

import './nutrient_info.dart';

abstract class MealOption {
 
  @protected String title;
  @protected String image, source; //image, source URLs
  @protected NutrientInfo nutrients; //calorie, fat, protein, carbs details
  //used to make additional API requests to retrieve information not given in initial response
  @protected int id;

  MealOption({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.source,
    this.nutrients, //nutrients not required for featured or meal plan recipes
  });

  //getters
  int get getId => id;
  String get getTitle => title;
  String get getImage => image;
  String get getSource => source;
  NutrientInfo get getNutrients => nutrients;
}