import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';


class FilterSliderPage extends StatefulWidget {
  const FilterSliderPage({super.key});

  @override
  State<FilterSliderPage> createState() => _FilterSliderPageState();
}

class _FilterSliderPageState extends State<FilterSliderPage> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text("Serving", style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Hellix'),),
                  ),

                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text( "Set Manually", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),
                  ),

                ],
                ),
                SizedBox(height: 10,),

                SfSlider(
                  min: 0.0,
                  max: 10.0,
                  value: recipeProvider.servingRange.start,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  activeColor: Colors.deepOrange,
                  enableTooltip: true,
                  showDividers: true,
                  onChanged: (newValue) {
                    recipeProvider.updateServingRange(newValue, recipeProvider.servingRange.end);
                  },
                ),


              ],
            ),
          ),

          SizedBox(height: 10,),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text("Preparation Time", style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Hellix'),),
                  ),

                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text( "Set Manually", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),
                  ),

                ],
                ),
                SizedBox(height: 10,),

                SfSlider(
                  min: 0.0,
                  max: 60.0,
                  value: recipeProvider.totalTimeRange.start,
                  interval: 10,
                  showTicks: true,
                  showLabels: true,
                  activeColor: Colors.deepOrange,
                  enableTooltip: true,
                  showDividers: true,
                  minorTicksPerInterval: 1,
                  onChanged: (newValue) {
                    recipeProvider.updateTotalTimeRange(newValue, recipeProvider.totalTimeRange.end);
                  },
                ),


              ],
            ),
          ),

          SizedBox(height: 10,),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text("Calories", style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Hellix'),),
                  ),

                  Container(
                    padding: EdgeInsets.only(top:30.0),
                    child: Text( "Set Manually", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),
                  ),

                ],
                ),
                SizedBox(height: 10,),

                SfSlider(
                  min: 0.0,
                  max: 1000.0,
                  value: recipeProvider.caloriesRange.start,
                  interval: 100,
                  showTicks: true,
                  showLabels: true,
                  activeColor: Colors.deepOrange,
                  enableTooltip: true,
                  showDividers: true,
                  minorTicksPerInterval: 1,
                  onChanged: (newValue) {
                    recipeProvider.updateCaloriesRange(newValue, recipeProvider.caloriesRange.end);
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
