import 'package:daily_recipes_final/widgets/zoom_drawer.widget/drawer_header.widget.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipes_final/models/menu.model.dart';

class MenuItems {
  static const Home = MenuItem('Home', Icons.home);
  static const RecentlyViewed = MenuItem('RecentlyViewed', Icons.play_circle_outline);
  static const Favourites = MenuItem('Favourites', Icons.favorite_outlined);
  static const Ingredients = MenuItem('Ingredients', Icons.play_circle_outline);
  static const Filter = MenuItem('Filter', Icons.filter_alt_outlined);
  static const Setting = MenuItem('Setting', Icons.settings_outlined);
  static const SignOut = MenuItem('Sign Out', Icons.output_outlined);

  static const all = <MenuItem>[
    Home,
    RecentlyViewed,
    Favourites,
    Ingredients,
    Filter,
    Setting,
    SignOut,
  ];
}

class ZoomMenuScreen extends StatelessWidget {
  final MenuItem currentItems;
  final ValueChanged<MenuItem> onSelectedItems;

  const ZoomMenuScreen({
    Key? key,
    required this.currentItems,
    required this.onSelectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.dark(),
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderDrawer(),
            Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(flex: 2),
          ],
        ),
      ),
    ),
  );

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    selectedTileColor: Colors.deepOrange,
    child: ListTile(
      selectedTileColor: Colors.grey.shade200,
      selected: currentItems == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon,color: currentItems == item ? Colors.deepOrange : Colors.grey.shade500,
        size: 25,),
      title: Text(item.title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,color: currentItems == item ? Colors.deepOrange : Colors.grey.shade500,
        fontFamily: 'Hellix', ),),
      onTap: () => onSelectedItems(item),
    ),
  );
}
