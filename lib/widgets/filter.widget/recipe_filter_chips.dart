import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FilterChipsWidget extends StatefulWidget {
  const FilterChipsWidget({super.key});

  @override
  State<FilterChipsWidget> createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text("Meal", style: TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Hellix'),),
          ),

          SizedBox(height: 10,),

          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: Text('Breakfast'),
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.deepOrange[100],
                  labelStyle: TextStyle(
                    color: recipeProvider.selectedType == 'Breakfast'
                        ? Colors.deepOrange
                        : Colors.grey.shade500,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hellix',
                  ),
                  showCheckmark: false,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: recipeProvider.selectedType == 'Breakfast'
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  ),
                  selected: recipeProvider.selectedType == 'Breakfast',
                  onSelected: (selected) {
                    if (selected) {
                      recipeProvider.updateTypeFilter('Breakfast');
                      // }else {
                      //  recipeProvider.removeTypeFilter;
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),

                SizedBox(width: 10,),

                FilterChip(
                  label: Text('Lunch'),
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.deepOrange[100],
                  labelStyle: TextStyle(
                    color: recipeProvider.selectedType == 'Lunch'
                        ? Colors.deepOrange
                        : Colors.grey.shade500,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hellix',
                  ),
                  showCheckmark: false,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: recipeProvider.selectedType == 'Lunch'
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  ),
                  selected: recipeProvider.selectedType == 'Lunch',
                  onSelected: (selected) {
                    if (selected) {
                      recipeProvider.updateTypeFilter('Lunch');
                      // }else {
                      //  recipeProvider.removeTypeFilter;
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),

                SizedBox(width: 10,),

                FilterChip(
                  label: Text('Dinner'),
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.deepOrange[100],
                  labelStyle: TextStyle(
                    color: recipeProvider.selectedType == 'Dinner'
                        ? Colors.deepOrange
                        : Colors.grey.shade500,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hellix',
                  ),
                  showCheckmark: false,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: recipeProvider.selectedType == 'Dinner'
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  ),
                  selected: recipeProvider.selectedType == 'Dinner',
                  onSelected: (selected) {
                    if (selected) {
                      recipeProvider.updateTypeFilter('Dinner');
                      // }else {
                      //  recipeProvider.removeTypeFilter;
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




