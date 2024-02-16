
import 'package:daily_recipes_final/firebase_options.dart';
import 'package:daily_recipes_final/pages/main_pages/login_page.dart';
import 'package:daily_recipes_final/pages/splash_screen/splash_screen.dart';
import 'package:daily_recipes_final/provider/ads_ingredients.provider.dart';
import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:daily_recipes_final/provider/ingredient.provider.dart';
import 'package:daily_recipes_final/provider/recipe.provider.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/recipe_drawer.widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_kit/overlay_kit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  } catch (e) {
    print(
        '<<<<=====Error In init Prefrences ${e}=====>>>>');
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppAuthProvider()),
    ChangeNotifierProvider(create: (_) => IngredientsProvider()),
    ChangeNotifierProvider(create: (_) => AdsIngredientsProvider()),
    ChangeNotifierProvider(create: (context) => RecipeProvider()),
  ], child:const MyApp( )));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OverlayKit(child: MaterialApp(
      title: 'Daily Recipe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),

      // home: const MyHomePage(title: 'Daily Recipe'),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Daily Recipe'),
        '/login': (context) => LogInPage(),
        '/home': (context) => ZoomDrawerMenu(),
      },

    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashScreenPage());
  }
}

