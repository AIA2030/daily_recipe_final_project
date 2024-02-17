import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/ingredients.widget/Ingredients_details.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RecipeViewWidget extends StatefulWidget {
  final Recipe recipe;

  const RecipeViewWidget({ required this.recipe, super.key});
  @override
  State<RecipeViewWidget> createState() => _RecipeViewWidgetState();
}

class _RecipeViewWidgetState extends State<RecipeViewWidget> {
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
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child:ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child:Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(

                        child: Text(widget.recipe?.type ?? 'No Name', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.cyan, fontFamily: 'Hellix'),),

                      ),

                      SizedBox(height: 5,),

                      Container(
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                child: Wrap (
                                  children: [
                                  SizedBox (
                                       width: 290,
                                      child:Text( widget.recipe?.title ?? 'No Title', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Hellix'),),
                                  )],
                                ),
                              ),

                              SizedBox(width: 20,),

                              Container(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
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

                            ]
                        ),

                      ),

                      SizedBox(height: 5,),

                      Container(
                        child: Column(
                          children: <Widget>[
                            Transform.translate(
                              offset:Offset(0, 0),
                              child:Container(
                                padding: EdgeInsets.all(5),
                                height: 350,
                                width: 450,
                                child:  Image.network(widget.recipe?.image ?? 'Not Found Image',fit: BoxFit.fill, width: 400, height: 350,),
                              ),)
                          ],
                        ),

                      ),

                      SizedBox(height: 10,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Container(
                              child: RatingBar.builder(
                                initialRating: ((widget.recipe?.rate ?? 0) / 5.0) * 5.0.toDouble(),
                                maxRating: 1,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.deepOrange,size: 4 ),
                                onRatingUpdate: (rating) => setState(() {
                                  this.rating = rating;
                                }

                                ),

                              )

                          ),

                          SizedBox(width: 60,),

                          Container(
                            child: Text( 'Rates: ${widget.recipe?.rate}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),


                          ),
                        ],
                      ),

                      SizedBox(height: 10,),

                      Container(

                        child: Text( 'Calories: ${widget.recipe?.calories}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),


                      ),

                      SizedBox(height: 10,),

                      Container(
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children:
                          [
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.clock, color: Colors.grey, size: 12),
                                SizedBox(width: 5,),
                                Text( 'Total Time:  ${widget.recipe?.total_time}', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.grey, fontFamily: 'Hellix'),),

                              ],
                            ),

                            SizedBox(width: 60,),

                            Row(
                              children: [
                                Icon(FontAwesomeIcons.bellConcierge, color: Colors.grey, size: 12),
                                SizedBox(width: 5,),
                                Text( 'Serving:  ${widget.recipe?.serving}', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.grey, fontFamily: 'Hellix'),),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        child: Text( widget.recipe?.describtion ?? 'No Name', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        child: Text("Ingredients", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Hellix'),),
                      ),

                      SizedBox(height: 5,),

                      SizedBox(
                        child: IngredientsDetailsWidget (recipe: widget.recipe!,),
                      ),
                      SizedBox(height: 20,),

                      Container(
                        child: Text("directions", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Hellix'),),
                      ),

                      SizedBox(height: 5,),

                      Container(
                        padding: EdgeInsets.all(10),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                          List.generate(
                            widget.recipe?.directions?.length ?? 0,
                                (index) => Padding(padding: EdgeInsets.all(5),
                              child: Text(
                                '${widget.recipe.directions!.keys.toList()[index]}: ${widget.recipe.directions!.values.toList()[index]}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontFamily: 'Hellix',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        },),


      ),
    );

  }
}
