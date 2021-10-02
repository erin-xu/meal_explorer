import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../screens/results_view.dart';
import '../models/search_result.dart';

class SearchTile extends StatelessWidget {
  final String query, type;

  SearchTile({this.query, this.type});

  //key: meal option, value: corresponding icon
  final Map<String, IconData> icons = {
    'Recipes': Icons.book_outlined,
    'Menu Items': Icons.restaurant_rounded,
    'Grocery Products': Icons.local_grocery_store_rounded,
  };

  //key: meal option, value: corresponding icon
  final Map<String, Color> colors = {
    'Recipes': Colors.green[300],
    'Menu Items': Colors.lightBlue[200],
    'Grocery Products': Colors.red[200],
  };

  //key: meal option, value: corresponding description
  final Map<String, String> descriptions = {
    'Recipes': 'Step-by-step instructions for home-cooked meals',
    'Menu Items': 'Meals from over 800 restaurant chains',
    'Grocery Products': 'Packaged products at grocery stores',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //displays ResultsView, creates SearchResult
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultsView(
                    searchResult: SearchResult(query: query, type: type))));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.8,
          ),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        width: 400,
        height: 170,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: colors[type],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icons[type],
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //automatically adjust Text size to avoid overflowing of pixels
                  AutoSizeText(
                    '"$query" $type',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 18,
                      color: colors[type],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(descriptions[type]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
