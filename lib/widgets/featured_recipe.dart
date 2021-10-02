import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../screens/recipe_view.dart';

class FeaturedRecipe extends StatelessWidget {
  final String title, image, source;

  FeaturedRecipe({this.title, this.image, this.source});

  @override
  Widget build(BuildContext context) {

    //checks if image is null to avoid error
    Container picture() {
      if (image == null) {
        return Container(
          width: MediaQuery.of(context).size.width - 160,
          height: MediaQuery.of(context).size.width - 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[350]),
          ),
          child: Text('No Image Available'), //instead of image
        );
      }
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 160,
        height: MediaQuery.of(context).size.width - 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: NetworkImage(image),
          ),
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          //passes title and source to RecipeView
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RecipeView(title: title, source: source)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 130,
          height: MediaQuery.of(context).size.height / 2 - 50,
          padding: EdgeInsets.only(
            right: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              picture(),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  minFontSize: 18,
                  maxFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));
  }
}
