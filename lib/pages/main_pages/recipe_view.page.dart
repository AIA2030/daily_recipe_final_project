import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/recipe_view.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeViewPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeViewPage({ required this.recipe, super.key});

  @override
  State<RecipeViewPage> createState() => _RecipeViewPageState();
}

class _RecipeViewPageState extends State<RecipeViewPage> {
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
