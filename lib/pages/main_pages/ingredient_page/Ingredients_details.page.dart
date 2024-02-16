import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/ingredients.widget/Ingredients_details.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsDetailsPage extends StatefulWidget {
  final Recipe recipe;

  const IngredientsDetailsPage({ required this.recipe, super.key});
  @override
  State<IngredientsDetailsPage> createState() => _IngredientsDetailsPageState();
}

class _IngredientsDetailsPageState extends State<IngredientsDetailsPage> {
  @override
  void initState() {
    if (widget.recipe.docId != null) {
      Provider.of<RecipeProvider>(context, listen: false)
          .addRecipesToUserViewed(widget.recipe.docId!);}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
        body: ListTile(
            subtitle: IngredientsDetailsWidget(recipe:  widget.recipe!)
        ));


  }
}
