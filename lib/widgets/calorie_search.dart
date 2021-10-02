import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../screens/plan_view.dart';
import '../models/meal_plan.dart';

class CalorieSearch extends StatelessWidget {
  final TextEditingController _textController = new TextEditingController();
  final _fieldKey = GlobalKey<FormState>();

  getPlan(BuildContext context, int calories) async {
    try {
      String url =
          "https://api.spoonacular.com/mealplanner/generate?apiKey=5fcc574d7b9843398dfa0258dbda3d86&timeFrame=day&targetCalories=$calories";

      var response = await http.get(url);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(jsonData);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PlanView(plan: mealPlan)));
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      height: 370,
      width: 300,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(bottom: 8),
            child: IconButton(
              icon: Icon(
                Icons.clear,
                size: 25,
              ),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Text('Day Meal Plan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[500],
              )),
          SizedBox(height: 50),
          SizedBox(
            width: 250,
            child: Text(
              'Enter a calorie target to generate a day meal plan.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 200,
            child: Row(
              children: <Widget>[
                Form(
                  key: _fieldKey,
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Target Calories',
                      ),
                      controller: _textController,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      validator: (String text) {
                        int number = num.tryParse(text);
                        if (number == null) {
                          return 'Enter a number';
                        } else if (number <= 0) {
                          return 'Must be greater than 0';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    if (_fieldKey.currentState.validate()) {
                      getPlan(context, num.parse(_textController.text));
                    }
                  },
                  child: Container(
                    child: Icon(Icons.search, color: Colors.deepPurple[400]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}