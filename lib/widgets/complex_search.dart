import 'package:flutter/material.dart';

import '../screens/results_view.dart';
import '../models/search_result.dart';

class ComplexSearch extends StatefulWidget {
  @override
  _ComplexSearchState createState() => _ComplexSearchState();
}

class _ComplexSearchState extends State<ComplexSearch> {

  //to access inputted query
  final TextEditingController _queryControl = new TextEditingController();
  //to call field validators
  final _formKey = GlobalKey<FormState>();
  //to indicate the selected MealOption
  String _mealOptionValue = 'Recipes';
  //to access inputted nutrient parameters
  final controllers = <String, List<TextEditingController>>{
    'Calories': [TextEditingController(), TextEditingController()],
    'Fat': [TextEditingController(), TextEditingController()],
    'Protein': [TextEditingController(), TextEditingController()],
    'Carbs': [TextEditingController(), TextEditingController()],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          height: 600,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                //clear button
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
              Text(
                'Search by Nutrients',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple[500],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Query',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    width: 210,
                    height: 50,
                    //query field
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search query',
                        helperText: ' ',
                      ),
                      textAlign: TextAlign.start,
                      controller: _queryControl,
                      style: TextStyle(
                          fontSize: 14, color: Colors.deepPurple[400]),
                      //query cannot be empty
                      validator: (String query) {
                        if (query.isEmpty) {
                          return 'Query cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              //nutrient fields
              getRow('Calories'),
              getRow('Fat'),
              getRow('Protein'),
              getRow('Carbs'),
              SizedBox(
                height: 20,
              ),
              Text(
                'Choose a Meal Option',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              //meal option drop down field
              DropdownButton(
                  value: _mealOptionValue,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 25,
                  ),
                  items: <String>['Recipes', 'Grocery Products', 'Menu Items']
                      .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  //updates selected value
                  onChanged: (String val) {
                    setState(() {
                      _mealOptionValue = val;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              OutlineButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.deepPurple[600], fontSize: 18),
                ),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                //calls validator methods to check validity of inputted parameters
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultsView(
                                    searchResult: SearchResult(
                                  type: _mealOptionValue,
                                  query: _queryControl.text,
                                  minCal: controllers['Calories'][0].text,
                                  maxCal: controllers['Calories'][1].text,
                                  minFat: controllers['Fat'][0].text,
                                  maxFat: controllers['Fat'][1].text,
                                  minProtein: controllers['Protein'][0].text,
                                  maxProtein: controllers['Protein'][1].text,
                                  minCarbs:
                                      controllers['Carbs'][0].text,
                                  maxCarbs:
                                      controllers['Carbs'][1].text,
                                ))));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //returns a row with min and max nutrient fields
  Row getRow(String nutrient) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Text(
            nutrient,
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          width: 100,
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Min',
              helperText: ' ',
            ),
            textAlign: TextAlign.start,
            controller: controllers[nutrient][0],
            style: TextStyle(fontSize: 14, color: Colors.deepPurple[400]),
            //if text is entered into the min field, it must be a number greater than or equal to 0
            validator: (String text) {
              int number = num.tryParse(text);
              if (text != '' && number == null) {
                return 'Enter a number';
              } else if (text != '' && number < 0){
                return 'Can\'t be negative';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: 100,
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Max',
              helperText: ' ',
            ),
            textAlign: TextAlign.start,
            controller: controllers[nutrient][1],
            style: TextStyle(fontSize: 14, color: Colors.deepPurple[400]),
            //if text is entered into the max field, it must be a positive number larger than min
            validator: (String text) {
              int number = num.tryParse(text);
              if (text != '' && number == null) {
                return 'Enter a number';
              } else if (text != '' && number <= 0){
                return 'Greater than 0';
              }else if (number != null) {
                int min = num.tryParse(controllers[nutrient][0].text);
                if (min != null && min > number) {
                  return 'Greater than min';
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
