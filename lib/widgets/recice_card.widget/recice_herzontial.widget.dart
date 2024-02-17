import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/pages/main_pages/recipe_view.page.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class RecipeHerzontialWidget extends StatefulWidget {
  final Recipe? recipe;
  final VoidCallback? onSearch;
  const RecipeHerzontialWidget({required this.recipe, this.onSearch, super.key});

  @override
  State<RecipeHerzontialWidget> createState() => _RecipeHerzontialWidgetState();
}

class _RecipeHerzontialWidgetState extends State<RecipeHerzontialWidget> {
  double rating = 0;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.recipe?.favourite_users_ids?.contains(
        FirebaseAuth.instance.currentUser?.uid) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 4,
            color: Colors.grey.shade50,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFavourite = !isFavourite;
                              Provider.of<RecipeProvider>(context, listen: false)
                                  .addRecipesToUserFavourite(
                                widget.recipe!.docId!,
                                isFavourite,
                              );
                            });
                          },
                          child: Icon(
                            isFavourite
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            size: 25,
                            color: isFavourite ? Colors.red : Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 100,
                          width: 150,
                          child: Image.network(
                            widget.recipe?.image ?? 'Not Found Image',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.recipe?.type ?? 'No Name',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.cyan,
                        fontFamily: 'Hellix',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeViewPage(recipe: widget.recipe!),
                          ),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            widget.recipe?.title ?? 'No Title',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontFamily: 'Hellix',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: ((widget.recipe?.rate ?? 0) / 5.0) * 5.0.toDouble(),
                          maxRating: 1,
                          itemCount: 5,
                          itemSize: 15.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: Colors.deepOrange,
                            size: 4,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              this.rating = rating;
                            });
                          },
                        ),
                        SizedBox(width: 25),
                        Text(
                          'Rates: ${widget.recipe?.rate}',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                            fontFamily: 'Hellix',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Calories: ${widget.recipe?.calories}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange,
                          fontFamily: 'Hellix',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.clock, color: Colors.grey.shade400, size: 12),
                                  SizedBox(width: 5),
                                  Text(
                                    'Total Time:  ${widget.recipe?.total_time}',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade400,
                                      fontFamily: 'Hellix',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.bellConcierge, color: Colors.grey.shade400, size: 12),
                                  SizedBox(width: 5),
                                  Text(
                                    'Serving:  ${widget.recipe?.serving}',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade400,
                                      fontFamily: 'Hellix',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
