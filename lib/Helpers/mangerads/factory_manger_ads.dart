import 'dart:convert';

import 'package:beinmatch/Helpers/mangerads/banner.dart';
import '../sheard_prefrancess.dart';
import 'interstitial.dart';

class FactoryAds{



  static final String BANER_AD = "banner";
  static final String INTERSTITIAL_AD = "interstitial";
  static FactoryAds? _instanc = null;

  static FactoryAds get instanc {
    if(_instanc == null){
      _instanc = FactoryAds();
      return _instanc!;
    }
    return _instanc!;
  }

  dynamic createFactoryAd(String typeAd){
      if(typeAd == BANER_AD){
        return BannerAds();
      }else if(typeAd == INTERSTITIAL_AD){
        return AdInterstitial.instanc;
      }
    throw new UnsupportedError("This message type is not allow");
  }

}