import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../screens/recipe_view.dart';
import '../models/meal_option.dart';

// ignore: must_be_immutable
class Preview extends StatelessWidget {
  MealOption _result;

  Preview({MealOption result}){
    _result = result;
  }

  //returns Map storing nutrient names with their corresponding values as a String to display
  Map<String, String> nutrientStrings() {
    String calString, fatString, proteinString, carbString;
    //if no data for the nutrient, String indicates no data
    if (_result.getNutrients.getCalories != null &&
        _result.getNutrients.getCalories is double) {
      calString = 'Calories: ${_result.getNutrients.getCalories} kcal';
    } else {
      calString = 'No calorie data';
    }
    if (_result.getNutrients.getFat != null && _result.getNutrients.getFat is double) {
      fatString = 'Fat: ${_result.getNutrients.getFat} g';
    } else {
      fatString = 'No fat data';
    }
    if (_result.getNutrients.getProtein != null &&
        _result.getNutrients.getProtein is double) {
      proteinString = 'Protein: ${_result.getNutrients.getProtein} g';
    } else {
      proteinString = 'No protein data';
    }
    if (_result.getNutrients.getCarbs != null && _result.getNutrients.getCarbs is double) {
      carbString = 'Carbohydrates: ${_result.getNutrients.getCarbs} g';
    } else {
      carbString = 'No carbohydrate data';
    }
    return {
      'calories': calString,
      'fat': fatString,
      'protein': proteinString,
      'carbs': carbString,
    };
  }

  @override
  Widget build(BuildContext context) {
    var strings = nutrientStrings();
    return GestureDetector(
      //if a source URL exists, RecipeView displays the website when Preview tapped
      onTap: () {
        if (_result.getSource != '') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RecipeView(title: _result.getTitle, source: _result.getSource)));
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          height: 150,
          width: 500,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            border: Border.all(color: Colors.grey, width: 0.8),
          ),
          child: Row(
            children: <Widget>[
              //MealOption image displayed
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[350],
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(_result.getImage),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                width: 216,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 38,
                      //title is autosized to avoid overflowing pixels
                      child: AutoSizeText(
                        _result.getTitle,
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey),
                        maxLines: 2,
                        minFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //nutrient data displayed
                    Text(
                      strings['calories'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      strings['fat'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      strings['protein'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      strings['carbs'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}