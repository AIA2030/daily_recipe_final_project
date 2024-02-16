import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipes_final/models/ingredient.model.dart';
import 'package:daily_recipes_final/utils/toast_message_status.dart';
import 'package:daily_recipes_final/widgets/toast_message.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientsList;

  List<Ingredient>? get ingredientsList => _ingredientsList;

  Future<void> getIngredients() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ingredients').get();

      if (result.docs.isNotEmpty) {
        _ingredientsList = List<Ingredient>.from(
            result.docs.map((doc) => Ingredient.fromJson(doc.data(), doc.id)));
        print("Success to recive list");
        print(result);
        print("Error in list ${ingredientsList?.length}");
      } else {
        _ingredientsList = [];
      }
      notifyListeners();
      print(result);
    } catch (e) {
      _ingredientsList = [];
      notifyListeners();
    }
  }

  Future<void> addIngredientsToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('ingredients').doc(ingredientId).update(
            {"users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
            });
      } else {
        await FirebaseFirestore.instance.collection('ingredients').doc(ingredientId).update(
            {"users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      OverlayLoadingProgress.stop();
      getIngredients();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

}