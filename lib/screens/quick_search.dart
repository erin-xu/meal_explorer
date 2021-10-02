import 'package:flutter/material.dart';

import '../widgets/search_tile.dart';

class QuickSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Enter Search Query';
  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 18,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          color: Colors.black45,
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_left_rounded),
      color: Colors.black45,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            SearchTile(query: query, type: 'Recipes'),
            SizedBox(height: 20),
            SearchTile(query: query, type: 'Grocery Products'),
            SizedBox(height: 20),
            SearchTile(query: query, type: 'Menu Items'),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
