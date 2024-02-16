import 'package:daily_recipes_final/pages/main_pages/Filter_pages/filter_result.page.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/filter.widget/recipe_filter_chips.dart';
import 'package:daily_recipes_final/widgets/filter.widget/recipe_filter_slider.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

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
          child:LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hellix'
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom:30.0),
                          child: TextButton(onPressed: () {
                            recipeProvider.resetFilters();
                          },
                            child: Text("Reset", style: TextStyle(fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrange,
                                fontFamily: 'Hellix'),),),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    SizedBox(
                      child: FilterChipsWidget(),
                    ),

                    SizedBox(height: 10,),

                    SizedBox(
                      child: FilterSliderPage(),
                    ),

                    SizedBox(height: 60,),

                    SizedBox(
                      child:Center(
                        child: Container(
                          height: 50.0,
                          width: 315,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: InkWell(
                            onTap: () async {
                              await recipeProvider.getFilteredRecipes();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterResultPage(filteredRecipes: recipeProvider.filteredRecipes),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    fontFamily: 'Hellix'
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );})),
    );
  }
}




