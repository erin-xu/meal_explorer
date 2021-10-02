//imported libraries
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//dart file references
import '../models/recipe.dart';
import './quick_search.dart';
import '../widgets/featured_recipe.dart';
import '../widgets/calorie_search.dart';
import '../widgets/complex_search.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<Recipe> _recipes = []; //holds featured recipes

  //retrieves featured recipes
  getRecipes() async {
    try {
      String url =
          "https://api.spoonacular.com/recipes/random?apiKey=5fcc574d7b9843398dfa0258dbda3d86&number=3";

      var response = await http.get(url);
      _recipes.clear();
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["recipes"].forEach((element) {
        Recipe recipe = new Recipe.noNutrients(element); //featured recipes do not display nutrient info
        _recipes.add(recipe);
      });
      setState(() {}); //updates the screen
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  void initState() {
    getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white38, //milder white color
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Explore',
          style: TextStyle(color: Colors.black, fontSize: 35),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 40,
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: QuickSearch(), //transitions to QuickSearch screen
                );
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Featured Recipes',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 40),
            //horizontally scrollable row of featured recipes
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _recipes.length,
                  (int index) {
                    return FeaturedRecipe(
                      title: _recipes[index].getTitle,
                      image: _recipes[index].getImage,
                      source: _recipes[index].getSource,
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  //displays CalorieSearch
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(child: CalorieSearch());
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            /*Food Network. “Meal Prep Ideas.” Food Network, Discovery, 2021, www.foodnetwork.com/fn-dish/recipes/2020/1/meal-
                                   prep-ideas-food-network-staffers.*/
                            image: NetworkImage(
                                'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2017/8/7/0/HE_Meal_Prep_BBQ_Chicken.s4x6.jpg.rend.hgtvcom.476.317.suffix/1502121357641.jpeg'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Meal Plans',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  //displays ComplexSearch
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: ComplexSearch(),
                          );
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            /*American Heart Association. “How Can I Eat More Nutrient-Dense Foods” American Heart Association, 2021, 
                                   https://www.heart.org/en/healthy-living/healthy-eating/eat-smart/nutrition-basics/how-can-i-eat-more-nutrient-dense-foods*/
                            image: NetworkImage(
                                'https://www.heart.org/-/media/images/healthy-living/healthy-eating/superfoods.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Search by Nutrients',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
