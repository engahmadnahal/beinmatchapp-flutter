
import 'dart:convert';

import 'package:beinmatch/Helpers/mangerads/manger-ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../sheard_prefrancess.dart';
import 'factory.dart';

class AdInterstitial implements IFactoryAd {

  static bool isReady = false;
   late InterstitialAd interstitialAd;
   static AdInterstitial? _instance = null;
  late Map<String,dynamic> settingApp = jsonDecode(SheardHelper.getData('setting')!);


  static AdInterstitial get instanc {
     if(_instance == null){
       _instance = AdInterstitial();
       return _instance!;
     }
     return _instance!;
   }

    void loadInterstitialAd(){
    if(settingApp['ads_active'] == true){
      InterstitialAd.load(
          adUnitId: MangerAd.instanc.interstitial,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              isReady = true;
              interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
            },
          ));
    }

  }

   void showInterstitialAd(){
     if(isReady && settingApp['ads_active'] == true){
       interstitialAd.show();
     }
  }
}