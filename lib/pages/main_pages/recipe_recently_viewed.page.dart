import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_vertical.widget.dart';
import 'package:daily_recipes_final/widgets/recipe_searchbar.widget/recipe_section_searchbar.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';



class RecentlyViewedPage extends StatefulWidget {
  final Recipe? recipe;
  const RecentlyViewedPage({required this.recipe, super.key});

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
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
        leading: ZoomMenuWidget(),
        actions: [
          IconButton(onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined, size: 25, color: Colors.black87,)),
        ],
      ),

      body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text( "Recently Viewed", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Hellix'),),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                      height: 100,
                      child:RecentlyViewedSearchBarPage(),
                    ),
                  ),

                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('recipes')
                        .where("recently_Viewed_users_ids",
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshots.hasError) {
                          return const Text('ERROR WHEN GET DATA');
                        }else {
                          if (snapshots.hasData) {
                            List<Recipe> recipeList = snapshots.data?.docs
                                .map((e) => Recipe.fromJson(e.data(), e.id))
                                .toList() ?? [];
                            return ListTile(
                              subtitle: Column(
                                children: recipeList.map((e) => RecipeVerticalWidget(recipe: e)).toList(),
                              ),
                            );
                          } else {
                            return const Text('No Data Found');
                          }
                        }
                      }
                    },
                  ),
                ],
              ),


            );
          }

          )
      ),
    );
  }
}
