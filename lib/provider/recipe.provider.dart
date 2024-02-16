import 'package:daily_recipes_final/models/recipe.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipes_final/utils/toast_message_status.dart';
import 'package:daily_recipes_final/widgets/toast_message.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:flutter/material.dart';

class RecipeProvider extends ChangeNotifier{


  List<Recipe>? _filteredRecipes;

  List<Recipe>? get filteredRecipes => _filteredRecipes;

  String _selectedType = "Breakfast, Lunch, Dinner";
  RangeValues _servingRange = const RangeValues(0, 10);
  RangeValues _totalTimeRange = const RangeValues(0, 60);
  RangeValues _caloriesRange = const RangeValues(0, 1000);

  String get selectedType => _selectedType;
  RangeValues get servingRange => _servingRange;
  RangeValues get totalTimeRange => _totalTimeRange;
  RangeValues get caloriesRange => _caloriesRange;

  void updateFilter(String type, RangeValues serving, RangeValues total_Time, RangeValues calories) {
    _selectedType = type;
    _servingRange = serving;
    _totalTimeRange = total_Time;
    _caloriesRange = calories;
    notifyListeners();
  }

  Future<void> getFilteredRecipes() async {
    try {
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('recipes');

      if (selectedType != null && selectedType.isNotEmpty) {
        query = query.where('type', isEqualTo: selectedType);
      }

      if (servingRange.start != 0 || servingRange.end != 10) {
        query = query.where('serving', isGreaterThanOrEqualTo: servingRange.start);
        query = query.where('serving', isLessThanOrEqualTo: servingRange.end);
      }

      if (totalTimeRange.start != 0 || totalTimeRange.end != 60) {
        query = query.where('total_time', isGreaterThanOrEqualTo: totalTimeRange.start);
        query = query.where('total_time', isLessThanOrEqualTo: totalTimeRange.end);
      }

      if (caloriesRange.start != 0 || caloriesRange.end != 1000) {
        query = query.where('calories', isGreaterThanOrEqualTo: caloriesRange.start);
        query = query.where('calories', isLessThanOrEqualTo: caloriesRange.end);
      }

      var snapshot = await query.get();
      _filteredRecipes = snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching filtered recipes: $e');
    }
  }

  void updateTypeFilter(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void updateServingRange(double start, double end) {
    _servingRange = RangeValues(start, end);
    notifyListeners();
  }

  void updateTotalTimeRange(double start, double end) {
    _totalTimeRange = RangeValues(start, end);
    notifyListeners();
  }

  void updateCaloriesRange(double start, double end) {
    _caloriesRange = RangeValues(start, end);
    notifyListeners();
  }

  void resetFilters() {
    _selectedType = "Breakfast, Lunch, Dinner";
    _servingRange = const RangeValues(0, 10);
    _totalTimeRange = const RangeValues(0, 60);
    _caloriesRange = const RangeValues(0, 1000);
    notifyListeners();
  }



  List<Recipe>? _recipesList;

  List<Recipe>? get recipesList => _recipesList;

  List<Recipe>? _freshRecipesList;

  List<Recipe>? get freshRecipesList => _freshRecipesList;

  List<Recipe>? _recommandedRecipesList;

  List<Recipe>? get recommandedRecipesList => _recommandedRecipesList;

  Recipe? openedRecipe;

  Future<void> getSelectedRecipe (String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').doc(recipeId).get();

      if (result.data() != null) {
        openedRecipe = Recipe.fromJson(result.data()!, result.id);
      }else{
        return;
      }
      notifyListeners();
    }catch (e) {
      print('>>>error in update recipe<<<');
    }
  }

  Future<void> getRecipe () async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();

      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      }else{
        _recipesList = [];
      }
      notifyListeners();
    }catch (e) {
      _recipesList = [];
      notifyListeners();
    }
  }

  Future<void> getFreshRecipe () async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes')
          .where('isFresh', isEqualTo: true).limit(5).get();

      if (result.docs.isNotEmpty) {
        _freshRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      }else{
        _freshRecipesList = [];
      }
      notifyListeners();
    }catch (e) {
      _freshRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> getRecommandedRecipe () async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes')
          .where('isFresh', isEqualTo: false).limit(5).get();

      if (result.docs.isNotEmpty) {
        _recommandedRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      }else{
        _recommandedRecipesList = [];
      }
      notifyListeners();
    }catch (e) {
      _recommandedRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> addRecipesToUser(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
            });
      } else {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      OverlayLoadingProgress.stop();
      getRecipe();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),);
    }
  }

  Future<void> addRecipesToUserViewed(String recipeId, ) async {
    try {
      await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
          {"recently_Viewed_users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
          });
    } catch (e) {}
  }

  Future<void> removeRecipesToUserViewed(String recipeId) async {
    try {
      await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
          {"recently_Viewed_users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
          });
    } catch (e) {}
  }


  Future<void> addRecipesToUserRecentlyViewed(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"recently_Viewed_users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),);
    }
  }

  Future<void> removeRecipesToUserRecentlyViewed(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"recently_Viewed_users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),);
    }
  }

  Future<void> addRecipesToUserFavourite(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"favourite_users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
            });
      } else {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"favourite_users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),);
    }
  }

  Future<void> _updateRecipe (String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').doc(recipeId).get();
      Recipe? updateRecipe;
      if (result.data() != null) {
        updateRecipe = Recipe.fromJson(result.data()!, result.id);
      } else {
        return;
      }

      var recipesListIndex = recipesList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipesListIndex != -1) {
        recipesList?.removeAt(recipesListIndex!);
        recipesList?.insert(recipesListIndex!, updateRecipe);
      }

      var freshRecipesListIndex = freshRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipesListIndex != -1) {
        freshRecipesList?.removeAt(freshRecipesListIndex!);
        freshRecipesList?.insert(freshRecipesListIndex!, updateRecipe);
      }

      var recommandedRecipesListIndex = recommandedRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipesListIndex != -1) {
        recommandedRecipesList?.removeAt(recommandedRecipesListIndex!);
        recommandedRecipesList?.insert(recommandedRecipesListIndex!, updateRecipe);
      }

      notifyListeners();
    }catch (e) {
      print('>>>error in update recipe<<<');
    }
  }
}