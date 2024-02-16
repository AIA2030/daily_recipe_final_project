import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_vertical.widget.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:provider/provider.dart';

class FilterResultPage extends StatefulWidget {
  const FilterResultPage({Key? key, required List<Recipe>? filteredRecipes}) : super(key: key);

  List<Recipe>? get filteredRecipes => null;

  @override
  State<FilterResultPage> createState() => _FilterResultPageState();
}

class _FilterResultPageState extends State<FilterResultPage> {
  List<Recipe>? filteredRecipes;

  @override
  void initState() {
    super.initState();
    fetchFilteredRecipes();
  }

  void fetchFilteredRecipes() {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    filteredRecipes = recipeProvider.filteredRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined, size: 25, color: Colors.black87),
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: filteredRecipes != null && filteredRecipes!.isNotEmpty
            ? ListView.builder(
          itemCount: filteredRecipes!.length,
          itemBuilder: (context, index) {
            return RecipeVerticalWidget(
              recipe: filteredRecipes![index],
            );
          },
        )
            : Center(
          child: Text('No recipes found.'),
        ),
      ),
    );
  }
}


