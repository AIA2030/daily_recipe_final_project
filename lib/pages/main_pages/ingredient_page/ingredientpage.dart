
import 'package:daily_recipes_final/provider/ingredient.provider.dart';
import 'package:daily_recipes_final/widgets/ingredients.widget/ads_ingredients.widget.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {


  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
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
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10),
                child: SizedBox(
                  child: Container(
                    child: AdsIngredients(),
                  ),
                )
            ),
            Expanded(child: SizedBox(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Consumer<IngredientsProvider> (builder: (context, ingredientsProvider, _) => ingredientsProvider.ingredientsList == null
                    ? const CircularProgressIndicator()
                    :(ingredientsProvider.ingredientsList?.isEmpty ?? false)
                    ? const Text('No Data Found')
                    : ListView.builder(
                  itemCount: ingredientsProvider.ingredientsList!.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors. black87,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.deepOrange,
                          value: ingredientsProvider.ingredientsList![index].users_ids
                              ?.contains(FirebaseAuth.instance.currentUser?.uid),
                          onChanged: (value) {
                            ingredientsProvider.addIngredientsToUser(ingredientsProvider.ingredientsList![index].docId!,
                                value ?? false);},),

                        title: Text(ingredientsProvider.ingredientsList![index].name ?? 'No Name', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Hellix')),
                      ),
                    ),
                  ),),),),
            )),
          ],
        ),
      ),
    );
  }
}
