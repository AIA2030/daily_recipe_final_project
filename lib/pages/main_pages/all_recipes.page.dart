import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_herzontial.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';

class AllRecipesPage extends StatefulWidget {
  const AllRecipesPage({super.key});

  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  @override
  void initState() {
    Provider.of<RecipeProvider>(context, listen: false).getRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Consumer<RecipeProvider> (builder: (context, recipesProvider, _) => recipesProvider.recipesList == null
          ? const CircularProgressIndicator()
          :(recipesProvider.recipesList?.isEmpty ?? false)
          ? const Text('No Data Found')
          : FlexibleGridView(
        children: recipesProvider.recipesList!.map((e) => RecipeHerzontialWidget(recipe: e)).toList(),
        axisCount: GridLayoutEnum.twoElementsInRow,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      ),
    );
  }
}
