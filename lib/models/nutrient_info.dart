class NutrientInfo {
  //dart uses a leading underscore to indicate private fields
  double _calories, _fat, _protein, _carbs;

  NutrientInfo({double calories, double fat, double protein, double carbs}){
    _calories = calories;
    _fat = fat;
    _protein = protein;
    _carbs = carbs;
  }

  //getters
  double get getCalories => _calories;
  double get getFat => _fat;
  double get getProtein => _protein;
  double get getCarbs => _carbs;

  factory NutrientInfo.fromMap(Map<String, dynamic> parsedData) {
    double calories, fat, protein, carbs = 0;
    //iterates through nutrient maps to find desired nutrient data
    parsedData['nutrients'].forEach((element) {
      if (element['name'] == 'Calories') {
        calories = element['amount'];
      } else if (element['name'] == 'Fat') {
        fat = element['amount'];
      } else if (element['name'] == 'Protein') {
        protein = element['amount'];
      } else if (element['name'] == 'Carbohydrates') {
        carbs = element['amount'];
      }
    });
    return NutrientInfo(
      calories: calories,
      fat: fat,
      protein: protein,
      carbs: carbs,
    );
  }
}