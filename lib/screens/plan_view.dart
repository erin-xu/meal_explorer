import 'package:flutter/material.dart';

import '../models/meal_plan.dart';
import '../widgets/featured_recipe.dart';

class PlanView extends StatefulWidget {
  static MealPlan _plan;

  PlanView({MealPlan plan}){
    _plan = plan;
  }

  MealPlan get getPlan => _plan;

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  Widget _body = Container(
    alignment: Alignment.center,
    child: Text('Loading...'),
  );

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.white38,
          elevation: 0.0,
        ),
      ),
      body: _body,
    );
  }

  //Must be separate function because initState() cannot be async
  void loadPage() async {
    //waits for MealPlan recipe images to be retrieved
    await widget.getPlan.finishedInit;
    _body = Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Planned Meals',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[500],
              ),
            ),
            SizedBox(height: 40),
            //recipe images displayed in horizontally scrollable view of FeaturedRecipe
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.getPlan.getRecipes.length,
                  (int index) {
                    return FeaturedRecipe(
                      title: widget.getPlan.getRecipes[index].getTitle,
                      image: widget.getPlan.getRecipes[index].getImage,
                      source: widget.getPlan.getRecipes[index].getSource,
                    );
                  },
                ),
              ),
            ),
            //displays nutrient information from NutrientInfo of MealPlan
            Text(
              'Nutrients',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[500],
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Calories: ${widget.getPlan.getNutrients.getCalories} kcal',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Carbohydrates: ${widget.getPlan.getNutrients.getCarbs} g',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Fat: ${widget.getPlan.getNutrients.getFat} g',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Protein: ${widget.getPlan.getNutrients.getProtein} g',
              style: TextStyle(fontSize: 20),
            ),
          ]),
    );
    //rebuilds the screen
    setState(() {});
  }
}
