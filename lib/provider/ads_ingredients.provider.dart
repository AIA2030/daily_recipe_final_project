
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipes_final/models/ads_ingredients.model.dart';
import 'package:flutter/material.dart';

class AdsIngredientsProvider extends ChangeNotifier {
  List<Ads>? _adList;

  List<Ads>? get adList => _adList;

  Ads? _ad;

  Ads? get ad => _ad;

  int sliderIndex = 0;
  CarouselController? carouselController;

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void diposeCarousel(){
    carouselController = null;
  }

  void onDotTapped(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }

  void initCarousel() {
    carouselController = CarouselController();
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance.collection('ads').where('isActive', isEqualTo: true).get();

      if (result.docs.isNotEmpty){
        _adList = List<Ads>.from(result.docs.map((doc) => Ads.fromJson(doc.data(), doc.id)));
      } else {
        _adList =[];
      }
      notifyListeners();
    } catch (e) {
      _adList =[];
      notifyListeners();
    }
  }

  Future<void> getAddAds(String id) async {
    try {
      var result = await FirebaseFirestore.instance.collection('ads').doc(id).get();
      if(result.exists) {
        _ad = Ads.fromJson(result.data() ?? {}, result.id);
      }else {
        _ad = null;
      }
      notifyListeners();
    } catch (e)  {
      _ad = null;
      notifyListeners();
    }
  }
}