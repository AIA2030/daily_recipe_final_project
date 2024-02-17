
import 'package:daily_recipes_final/pages/main_pages/Filter_pages/filter_page.dart';
import 'package:daily_recipes_final/widgets/recipe_searchbar.widget/recipe_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  TextEditingController _searchController = TextEditingController();
  List searchResult = [];
  bool isSearching = false;

  void searchFromFirebase(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
        isSearching = true;
      });
    } catch (e) {
      print('Error searching for recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.shade100,
                      ),
                      height: 50,
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for recipes',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                              fontFamily: 'Hellix',
                            ),
                            border: InputBorder.none,
                            suffixIcon: IconButton(

                              icon: Icon(Icons.search_outlined,
                                  color: Colors.grey.shade500, size: 23),
                              onPressed: () {
                                searchFromFirebase(_searchController.text);
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                          ),
                          onChanged: (query) {},
                        ),
                      )
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade100,
                  ),
                  height: 50,
                  width: 45,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.sliders,
                        color: Colors.black87, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearching,
              child: Flexible(
                child: searchResult.isEmpty
                    ? Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
                    : ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeSearchWidget(
                                  recipeTitle: searchResult[index]['title'],
                                  recipe: Recipe.fromJson(searchResult[index], ''),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            searchResult[index]['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange,
                              fontFamily: 'Hellix',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FavoriteSearchBarPage extends StatefulWidget {
  const FavoriteSearchBarPage({Key? key}) : super(key: key);

  @override
  State<FavoriteSearchBarPage> createState() => _FavoriteSearchBarPageState();
}

class _FavoriteSearchBarPageState extends State<FavoriteSearchBarPage> {
  TextEditingController _searchController = TextEditingController();
  List searchResult = [];
  bool isSearching = false;

  void searchFavoriteRecipes(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .where("favourite_users_ids",
          arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
        isSearching = true;
      });
    } catch (e) {
      print('Error searching for favorite recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                    height: 50,
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for favorite recipes',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                            fontFamily: 'Hellix',
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search_outlined,
                                color: Colors.grey.shade500, size: 23),
                            onPressed: () {
                              searchFavoriteRecipes(_searchController.text);
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (query) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade100,
                  ),
                  height: 50,
                  width: 45,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.sliders,
                        color: Colors.black87, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearching,
              child: Flexible(
                child: searchResult.isEmpty
                    ? Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
                    : ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeSearchWidget(
                                  recipeTitle: searchResult[index]['title'],
                                  recipe: Recipe.fromJson(searchResult[index], ''),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            searchResult[index]['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange,
                              fontFamily: 'Hellix',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RecentlyViewedSearchBarPage extends StatefulWidget {
  const RecentlyViewedSearchBarPage({Key? key}) : super(key: key);

  @override
  State<RecentlyViewedSearchBarPage> createState() => _RecentlyViewedSearchBarPageState();
}

class _RecentlyViewedSearchBarPageState extends State<RecentlyViewedSearchBarPage> {
  TextEditingController _searchController = TextEditingController();
  List searchResult = [];
  bool isSearching = false;

  void searchRecentlyViewedRecipes(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .where("recently_Viewed_users_ids",
          arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
        isSearching = true;
      });
    } catch (e) {
      print('Error searching for recently recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                    height: 50,
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for recently recipes',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                            fontFamily: 'Hellix',
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search_outlined,
                                color: Colors.grey.shade500, size: 23),
                            onPressed: () {
                              searchRecentlyViewedRecipes(_searchController.text);
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (query) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade100,
                  ),
                  height: 50,
                  width: 45,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.sliders,
                        color: Colors.black87, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearching,
              child: Flexible(
                child: searchResult.isEmpty
                    ? Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
                    : ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeSearchWidget(
                                  recipeTitle: searchResult[index]['title'],
                                  recipe: Recipe.fromJson(searchResult[index], ''),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            searchResult[index]['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange,
                              fontFamily: 'Hellix',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
