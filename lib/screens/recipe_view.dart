import 'package:flutter/material.dart';
//corresponds to installed webview package
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class RecipeView extends StatelessWidget {
  static String _title, _source;

  RecipeView({String title, String source}){
    _title = title;
    _source = source;
  }

  String webViewUrl = ''; //stores https URL

@override
  Widget build(BuildContext context) {
    //changes http to https
    if (_source.contains('http://')) {
      webViewUrl = _source.replaceAll('http://', 'https://');
    } else {
      webViewUrl = _source;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(_title, textAlign: TextAlign.left, style: TextStyle(color: Colors.black38, fontSize: 18),),
        iconTheme: IconThemeData(color: Colors.black38),
      ),
      body: WebView(
        initialUrl: webViewUrl,
      ),
    );
  }
}