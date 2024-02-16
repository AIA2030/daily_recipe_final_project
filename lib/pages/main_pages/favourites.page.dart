import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:daily_recipes_final/widgets/recice_card.widget/recice_vertical.widget.dart';
import 'package:daily_recipes_final/widgets/recipe_searchbar.widget/recipe_section_searchbar.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Favouritespage extends StatefulWidget {
  const Favouritespage({super.key});

  @override
  State<Favouritespage> createState() => _FavouritespageState();
}

class _FavouritespageState extends State<Favouritespage> {
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
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text( "Favorites", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Hellix'),),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                      height: 80,
                      child:FavoriteSearchBarPage(),
                    ),
                  ),

                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('recipes')
                        .where("favourite_users_ids",
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
                            List<Recipe> recipesList = snapshots.data?.docs
                                .map((e) => Recipe.fromJson(e.data(), e.id))
                                .toList() ?? [];
                            return SizedBox(
                              child: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recipesList.map((e) => RecipeVerticalWidget(recipe: e)).toList(),
                                ),
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

          )),
    );
  }
}


