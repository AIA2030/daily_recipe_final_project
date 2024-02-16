
import 'package:daily_recipes_final/models/menu.model.dart';
import 'package:daily_recipes_final/pages/main_pages/all_recipes.page.dart';
import 'package:daily_recipes_final/pages/main_pages/zoom_menu.page.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_herzontial.widget.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_vertical.widget.dart';
import 'package:daily_recipes_final/widgets/recipe_searchbar.widget/recipe_section_searchbar.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItems = MenuItems.Home;
  bool isSearching = false;
  @override
  void initState() {
    Provider.of<RecipeProvider>(context, listen: false).getFreshRecipe();
    Provider.of<RecipeProvider>(context, listen: false).getRecommandedRecipe();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: ZoomMenuWidget(),
        actions: [
          IconButton(onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined, size: 25, color: Colors.black87,)),
        ],
      ),

      body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),

                  Container(
                    child: Text("Bonjour, Emma", style: TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400,
                        fontFamily: 'Hellix'),),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child: Text("What would you like to cook today?",
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black87,
                          fontFamily: 'Abril'),),
                  ),

                  SizedBox(height: 20,),


                  Column(
                    children: [

                      SizedBox(
                        height: 80,
                        child:SearchBarPage(),
                      ),

                      SizedBox(height: 10,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text("Today's Fresh Recipes", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hellix'),),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const AllRecipesPage()));
                            },
                              child: Text("See All", style: TextStyle(fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrange,
                                  fontFamily: 'Hellix'),),),
                          ),
                        ],
                      ),

                      SizedBox(height: 5,),

                      SizedBox(
                          height: 300,
                          child: Consumer<RecipeProvider>(
                              builder: (context, recipesProvider, _) =>
                              recipesProvider.freshRecipesList == null
                                  ? const CircularProgressIndicator()
                                  : (recipesProvider.freshRecipesList?.isEmpty ??
                                  false)
                                  ? const Text('No Data Found')
                                  : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recipesProvider.freshRecipesList!.length,
                                  itemBuilder: (context, index) =>
                                      RecipeHerzontialWidget(recipe: recipesProvider
                                          .freshRecipesList![index],
                                        onSearch: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => SearchBarPage(),
                                            ),
                                          );
                                        },
                                      )))),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text("Recommended", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hellix'),),
                          ),

                          SizedBox(width: 40,),

                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const AllRecipesPage()));
                            },
                              child: Text("See All", style: TextStyle(fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrange,
                                  fontFamily: 'Hellix'),),),
                          ),

                        ],
                      ),

                      SizedBox(height: 5,),

                      SizedBox(
                          height: 300,
                          child: Consumer<RecipeProvider>(
                              builder: (context, recipesProvider, _) =>
                              recipesProvider.recommandedRecipesList == null
                                  ? const CircularProgressIndicator()
                                  : (recipesProvider.recommandedRecipesList
                                  ?.isEmpty ?? false)
                                  ? const Text('No Data Found')
                                  : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: recipesProvider.recommandedRecipesList!
                                      .length,
                                  itemBuilder: (context, index) =>
                                      RecipeVerticalWidget(recipe: recipesProvider
                                          .recommandedRecipesList![index],
                                        onSearch: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => SearchBarPage(),
                                            ),
                                          );
                                        },

                                      ))
                          )),
                    ],
                  ),

                ],
              ),
            );
          })),
    );
  }
}

