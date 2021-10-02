//imported libraries
import 'dart:convert';
import 'package:http/http.dart' as http;

//dart file references
import './recipe.dart';
import './grocery_product.dart';
import './menu_item.dart';
import './meal_option.dart';

class SearchResult {
  String _type; //indicates meal option

  //not final because additional parameters must be added
  //key: parameter name, value: parameter value
  Map<String, String> _parameters = {
    'apiKey': '5fcc574d7b9843398dfa0258dbda3d86',
    'number': '6', //6 meal options returned from API
  };

  //corresponding URL path for each meal option
  final Map<String, String> _paths = {
    'Recipes': '/recipes/complexSearch',
    'Menu Items': '/food/menuItems/search',
    'Grocery Products': '/food/products/search',
  }; 

  //stores search results
  List<MealOption> _results = [];

  //getters
  String get getType => _type;
  List<MealOption> get getResults => _results;

  SearchResult({
    String type,
    String query,
    String minCal,
    String maxCal,
    String minFat,
    String maxFat,
    String minProtein,
    String maxProtein,
    String minCarbs,
    String maxCarbs,
  }) {
    _type = type;
    _parameters['query'] = query;
    _parameters['minCalories'] = minCal;
    _parameters['maxCalories'] = maxCal;
    _parameters['minCarbs'] = minCarbs;
    _parameters['maxCarbs'] = maxCarbs;
    _parameters['minFat'] = minFat;
    _parameters['maxFat'] = maxFat;
    _parameters['minProtein'] = minProtein;
    _parameters['maxProtein'] = maxProtein;
  }

  Future<List<MealOption>> getSearch() async {
    //stores keys with empty values
    var _emptyKeys = <String>[];
    _parameters.forEach((key, value) {
      if (value == null || value == '') {
        _emptyKeys.add(key);
      }
    });
    //removes key-value pairs with empty values
    _emptyKeys.forEach((key) {
      _parameters.remove(key);
     });
    //nutrient info can be retrieved in recipe search request
    if (_type == 'Recipes') {
      _parameters['addRecipeNutrition'] = 'true';
    }
    try {
      Uri uri = Uri.https('api.spoonacular.com', _paths[_type], _parameters);
      var response = await http.get(uri);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      //obtains data from API for corresponding meal option indicated by _type
      if (_type == 'Recipes') {
        List<Recipe> recipes = [];
        jsonData["results"].forEach((element) {
          Recipe recipe = new Recipe.withNutrients(element);
          recipes.add(recipe);
        });
        _results = recipes;
      }
      else if (_type == 'Menu Items') {
        List<MenuItem> items = [];
        int i = 0;
        while (i < jsonData['menuItems'].length) {
          MenuItem item = new MenuItem.fromMap(jsonData['menuItems'][i]);
          await item.finishedInit; //checks if nutrients have been retrieved
          items.add(item);
          i++;
        }
        _results = items;
      }
      else if (_type == 'Grocery Products') {
        List<Product> products = [];
        int i = 0;
        while (i < jsonData['products'].length) {
          Product product = new Product.fromMap(jsonData['products'][i]);
          await product.finishedInit; //checks if nutrients have been retrieved
          products.add(product);
          i++;
        }
        _results = products;
      }
      return _results;
    } catch (error) {
      throw error.toString();
    }
  }
}