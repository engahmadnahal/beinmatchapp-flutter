import 'dart:convert';

import 'package:beinmatch/Helpers/mangerads/manger-ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../sheard_prefrancess.dart';
import 'factory.dart';
class BannerAds extends StatefulWidget implements IFactoryAd {
  const BannerAds({Key? key}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {

   AdSize adSize = AdSize.banner;
   bool isReady = false;
   late BannerAd myBanner;
   late Map<String,dynamic> settingApp;

  void _createBanner(){
    myBanner = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: adSize,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isReady = true;
          });
          print('Ad loaded.');},
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );
    myBanner.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    settingApp = jsonDecode(SheardHelper.getData('setting')!);
    if(settingApp['ads_active'] == true){
      _createBanner();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(settingApp['ads_active'] == true) {
      myBanner.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(isReady){
      return Container(
        width: adSize.width.toDouble(),
        height: adSize.height.toDouble(),
        child: AdWidget(ad: myBanner),
      );
    }
    return  Container();

  }
}
