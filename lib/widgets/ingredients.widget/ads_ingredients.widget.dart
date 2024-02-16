import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipes_final/provider/ads_ingredients.provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdsIngredients extends StatefulWidget {
  const AdsIngredients({super.key});

  @override
  State<AdsIngredients> createState() => _AdsIngredientsState();
}

class _AdsIngredientsState extends State<AdsIngredients> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<AdsIngredientsProvider>(context, listen: false).getAds();
  }

  @override
  void dispose() {
    Provider.of<AdsIngredientsProvider>(context, listen: false).diposeCarousel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          child: Consumer<AdsIngredientsProvider> (builder: (context, adProvider, _) => adProvider.adList == null
              ? const CircularProgressIndicator()
              :(adProvider.adList?.isEmpty ?? false)
              ? const Text('No Data Found')
              : Column(
            children: [
              CarouselSlider(
                carouselController: adProvider.carouselController,
                options: CarouselOptions(
                    autoPlay: true,
                    height: 250,
                    viewportFraction: .75,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) => adProvider.onPageChanged(index),
                    enlargeFactor: 0.3),

                items: adProvider.adList!.map((ad) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:  const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage( fit: BoxFit.fitWidth, image: NetworkImage(ad.image!))),
                      ),
                      Padding(padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(25)),),),

                    ],
                  );
                }).toList(),
              ),
              DotsIndicator(dotsCount: adProvider.adList!.length,
                position: adProvider.sliderIndex,
                onTap: (position) => adProvider.onDotTapped(position),
                decorator: DotsDecorator(
                  color: Colors.black87,
                  activeColor: Colors.deepOrange,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            ],
          ),),
        )
    );
  }
}
