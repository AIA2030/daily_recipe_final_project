import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/pages/main_pages/recipe_view.page.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RecipeVerticalWidget extends StatefulWidget {
  final Recipe? recipe;
  final VoidCallback? onSearch;

  const RecipeVerticalWidget({required this.recipe, this.onSearch, super.key});

  @override
  State<RecipeVerticalWidget> createState() => _RecipeVerticalWidgetState();
}

class _RecipeVerticalWidgetState extends State<RecipeVerticalWidget> {
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
    return SafeArea(
      child: Flexible(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            reverse:true,
            scrollDirection: Axis.vertical,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(vertical: 10,),
                child:  Expanded(
                  child: Card(
                    elevation: 4,
                    color: Colors.grey.shade50,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: SizedBox(
                        // width: 230,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [

                            Center(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.topCenter,
                                child: Image.network(widget.recipe?.image ?? 'Not Found Image', fit: BoxFit.cover, height: 90, width: 90,),
                              ),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: <Widget> [

                                  Container(

                                    child: Text( widget.recipe?.type ?? 'No Name', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.cyan, fontFamily: 'Hellix'),),

                                  ),

                                  SizedBox(height: 5,),

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
                                          child: SizedBox(
                                              width: 200,
                                              child: Wrap(
                                                  children: <Widget> [
                                                    Text(
                                                      widget.recipe?.title ?? 'No Title',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black87,
                                                        fontFamily: 'Hellix',
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
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
                                        maxRating: 5,
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

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: <Widget> [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: <Widget> [
                                          Icon(FontAwesomeIcons.clock, color: Colors.grey.shade400, size: 12),
                                          SizedBox(width: 5,),
                                          Text( 'Total Time:  ${widget.recipe?.total_time}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
                                        ],
                                      ),

                                      SizedBox(width: 30,),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: <Widget> [
                                          Icon(FontAwesomeIcons.bellConcierge, color: Colors.grey.shade400, size: 12),
                                          SizedBox(width: 5,),
                                          Text( 'Serving:  ${widget.recipe?.serving}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
                                        ],
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),

                            Column(
                              children: <Widget> [
                                Container(
                                    child:  InkWell(
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
                                ),

                                SizedBox(height: 10,),

                                Container(
                                    child: InkWell(
                                        onTap: () {
                                          Provider.of<RecipeProvider>(context, listen: false).removeRecipesToUserRecentlyViewed(
                                              widget.recipe!.docId!,
                                              !(widget.recipe?.recently_viewed_users_ids?.contains(
                                                  FirebaseAuth.instance.currentUser?.uid) ?? false));
                                        },

                                        child: (widget.recipe?.recently_viewed_users_ids?.contains(
                                            FirebaseAuth.instance.currentUser?.uid) ?? false
                                            ? const Icon( Icons.bookmark_add_outlined, size: 25, color: Colors.deepOrange,)
                                            : const Icon( Icons.bookmark_remove_outlined, size: 25, color: Colors.grey,)))
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ),
          );
        }),
      ),
    );
  }
}
