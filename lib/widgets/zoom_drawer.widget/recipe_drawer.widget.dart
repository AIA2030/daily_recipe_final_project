import 'package:daily_recipes_final/models/menu.model.dart';
import 'package:daily_recipes_final/pages/main_pages/Filter_pages/filter_page.dart';
import 'package:daily_recipes_final/pages/main_pages/favourites.page.dart';
import 'package:daily_recipes_final/pages/main_pages/home_page.dart';
import 'package:daily_recipes_final/pages/main_pages/ingredient_page/ingredientpage.dart';
import 'package:daily_recipes_final/pages/main_pages/recipe_recently_viewed.page.dart';
import 'package:daily_recipes_final/pages/main_pages/setting_page.dart';
import 'package:daily_recipes_final/pages/main_pages/zoom_menu.page.dart';
import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ZoomDrawerMenu extends StatefulWidget {
  const ZoomDrawerMenu({Key? key}) : super(key: key);

  @override
  State<ZoomDrawerMenu> createState() => _ZoomDrawerMenuState();
}

class _ZoomDrawerMenuState extends State<ZoomDrawerMenu> {
  late ZoomDrawerController controller;
  MenuItem currentItems = MenuItems.Home;

  @override
  void initState() {
    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ZoomDrawer(
    style: DrawerStyle.defaultStyle,
    mainScreenTapClose: true,
    disableDragGesture: true,
    controller: controller,
    borderRadius: 40,
    angle: -10,
    slideWidth: MediaQuery.of(context).size.width * 0.65,
    drawerShadowsBackgroundColor: Colors.black26,
    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
    menuBackgroundColor: Colors.white,
    openCurve: Curves.fastOutSlowIn,
    closeCurve: Curves.bounceIn,
    showShadow: true,
    menuScreen: Builder(
      builder: (context) => ZoomMenuScreen(
        currentItems: currentItems,
        onSelectedItems: (item) {
          setState(() => currentItems = item);
          ZoomDrawer.of(context)!.close();
        },
      ),
    ),
    mainScreen: getScreen(),
  );

  Widget getScreen() {
    switch (currentItems) {
      case MenuItems.Ingredients:
        return IngredientsPage();

      case MenuItems.Favourites:
        return Favouritespage();

      case MenuItems.RecentlyViewed:
        return RecentlyViewedPage(recipe: null,);

      case MenuItems.Filter:
        return FilterPage();

      case MenuItems.Setting:
        return SettingPage();

    case MenuItems.SignOut:
    return  AlertDialog(
      backgroundColor: Colors.black87,
      title: Center(
        child: Text(
          'Sign Out',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            fontFamily: 'Hellix',
          ),
        ),
      ),
      content: Container(
        child: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            fontFamily: 'Hellix',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              fontFamily: 'Hellix',
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<AppAuthProvider>(context, listen: false)
                .signOut(context);
          },
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              fontFamily: 'Hellix',
            ),
          ),
        ),
      ],
    );

      case MenuItems.Home:
        return HomePage();
      default:
        return HomePage();
    }
  }
}







