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


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,),
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
                      children: <Widget> [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(bottom: 70.0),
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<RecipeProvider>(context, listen: false).addRecipesToUserFavourite(
                                            widget.recipe!.docId!,
                                            !(widget.recipe?.favourite_users_ids?.contains(
                                                FirebaseAuth.instance.currentUser?.uid) ?? false));
                                      },

                                      child: (widget.recipe?.favourite_users_ids?.contains(
                                          FirebaseAuth.instance.currentUser?.uid) ?? false
                                          ? const Icon( FontAwesomeIcons.solidHeart, size: 25, color: Colors.red,)
                                          : const Icon( FontAwesomeIcons.heart, size: 25, color: Colors.grey,)))),

                              SizedBox(width: 10,),

                              Container(
                                padding: EdgeInsets.all(5),
                                height: 100,
                                width: 150,
                                child: Image.network(widget.recipe?.image ?? 'Not Found Image', fit: BoxFit.cover,),
                              ),
                            ],
                          ),
                        ),
                        Container(

                          child: Text( widget.recipe?.type ?? 'No Name', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.cyan, fontFamily: 'Hellix'),),

                        ),

                        SizedBox(height: 2,),

                        Container(
                          child: InkWell(
                            onTap: () {
                              bool isViewed = widget.recipe?.recently_viewed_users_ids
                                  ?.contains(FirebaseAuth.instance.currentUser?.uid) ?? false;
                              Provider.of<RecipeProvider>(context, listen: false).addRecipesToUserRecentlyViewed(
                                  widget.recipe!.docId!,
                                  !(widget.recipe?.recently_viewed_users_ids?.contains(
                                      FirebaseAuth.instance.currentUser?.uid) ?? false));
                            },
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecipeViewPage(recipe: widget.recipe!),
                                    ),
                                  );
                                },
                                child: SizedBox (
                                  width: 200,
                                  child:Text( widget.recipe?.title ?? 'No Title', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: ((widget.recipe?.rate ?? 0) / 5.0) * 5.0.toDouble(),
                              maxRating: 1,
                              itemCount: 5,
                              itemSize: 15.0,
                              itemBuilder: (context, _) => Icon(Icons.star_rounded, color: Colors.deepOrange,size: 4 ),
                              onRatingUpdate: (rating) =>
                                  setState(() {
                                    this.rating = rating;
                                  }),
                            ),

                            SizedBox(width: 25,),

                            Text( 'Rates: ${widget.recipe?.rate}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),
                          ],
                        ),

                        SizedBox(height: 5,),

                        Container(
                          child: Text( 'Calories: ${widget.recipe?.calories}', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),
                        ),

                        SizedBox(height: 5,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Icon(FontAwesomeIcons.clock, color: Colors.grey.shade400, size: 12),
                                      SizedBox(width: 5,),
                                      Text( 'Total Time:  ${widget.recipe?.total_time}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
                                    ],
                                  ),

                                  SizedBox(width: 20,),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Icon(FontAwesomeIcons.bellConcierge, color: Colors.grey.shade400, size: 12),
                                      SizedBox(width: 5,),
                                      Text( 'Serving:  ${widget.recipe?.serving}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
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
        }
        ));
  }
}
