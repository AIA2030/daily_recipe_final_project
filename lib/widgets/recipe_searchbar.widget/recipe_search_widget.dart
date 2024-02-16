import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_vertical.widget.dart';
import 'package:daily_recipes_final/widgets/recipe_view.widget.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeSearchWidget extends StatefulWidget {
  final String recipeTitle;
  final Recipe recipe;
  const RecipeSearchWidget({ required this.recipeTitle,required this.recipe, super.key});

  @override
  State<RecipeSearchWidget> createState() => _RecipeSearchWidgetState();
}

class _RecipeSearchWidgetState extends State<RecipeSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,

          leading: IconButton(icon:
          Icon(Icons.arrow_back, size: 25, color: Colors.black87,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(onPressed: () {},
                icon: Icon(Icons.notifications_none_outlined, size: 25, color: Colors.black87,)),
          ],
        ),
        body: ListTile(
            subtitle: RecipeViewWidget(recipe: widget.recipe!)
        ));

  }
}