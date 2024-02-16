import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipes_final/models/ingredient.model.dart';
import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/provider/ingredient.provider.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsDetailsWidget extends StatefulWidget {
  final Recipe recipe;
  const IngredientsDetailsWidget({required this.recipe, super.key});

  @override
  State<IngredientsDetailsWidget> createState() => _IngredientsDetailsWidgetState();
}

class _IngredientsDetailsWidgetState extends State<IngredientsDetailsWidget> {

  @override
  void initState() {
    Provider.of<RecipeProvider>(context, listen: false)
        .addRecipesToUserViewed(widget.recipe.docId!);
    Provider.of<RecipeProvider>(context, listen: false).getRecipe();
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('ingredients').where('users_ids',
              arrayContains: FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              var userIngredients = List<Ingredient>.from(snapShot
                  .data!.docs
                  .map((e) => Ingredient.fromJson(e.data(), e.id))
                  .toList());

              var userIngredientsTitles =
              userIngredients.map((e) => e.name).toList();
              Widget checkIngredientWidget(String recipeIngredient) {
                bool isExsist = false;
                for (var userIngredientsTitle in userIngredientsTitles) {
                  if (recipeIngredient.contains(userIngredientsTitle!)) {
                    isExsist = true;
                    break;
                  } else {
                    isExsist = false;
                  }
                }

                if (isExsist) {
                  return Icon(Icons.check, size: 20, color: Colors.green, weight: 20,);
                } else {
                  return Icon(Icons.close, size: 20, color: Colors.red, weight: 80,);
                }
              }

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.recipe.ingredients
                      ?.map((e) => Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child:Text('- ${e}',   style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Hellix',
                        ),),),
                      SizedBox(width: 15,),
                      checkIngredientWidget(e)
                    ],
                  )).toList() ?? [],
                ),
              );
            }
          }),

    );

  }
}
