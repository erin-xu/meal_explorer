import 'package:flutter/material.dart';

import '../models/search_result.dart';
import '../widgets/preview.dart';

class ResultsView extends StatefulWidget {
  static SearchResult _searchResult;

  ResultsView({SearchResult searchResult}){
    _searchResult = searchResult;
  }

  SearchResult get getSearchResult => _searchResult;

  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  Widget _body = Text(
    'Loading...',
    style: TextStyle(fontSize: 20),
  );

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white38,
        elevation: 0.0,
        title: Text(
          widget.getSearchResult.getType,
          style: TextStyle(color: Colors.black, fontSize: 35),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        alignment: Alignment.topCenter,
        child: _body,
      ),
    );
  }

  void loadPage() async {
    await  widget.getSearchResult.getSearch();
    //avoids error by addressing the case of no results
    if (widget.getSearchResult.getResults.length == 0) {
      _body = Text(
        'No Results',
        style: TextStyle(fontSize: 20),
      );
    } else {
      _body = SingleChildScrollView(
        child: Column(
          //returns a list of Preview objects displaying each result
          children: List.generate(
            widget.getSearchResult.getResults.length,
            (int index) {
              return Preview(result: widget.getSearchResult.getResults[index]);
            },
          ),
        ),
      );
    }
    //rebuilds the screen
    setState(() {});
  }
}
