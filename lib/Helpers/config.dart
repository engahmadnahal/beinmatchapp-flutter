import 'package:beinmatch/controller/onbording.dart';
import 'package:flutter/cupertino.dart';

class Config {
  // Setting For Api
  static const String api_url = "http://app.ahmadnahal.com/api/v1/";
  
  // Setting For Style
  static int primaryColor = 0xFF07499F;
  static int secondaryColor = 0xFFD9A20A;
  static int errorColor = 0xFFCD0000;
  static const String primaryFont = "Tajawal";

  // Data For OnBording Screen
  static List<onBordingController> onbordData = [
    onBordingController(
        title: "مرحباً بك !",
        img1: "assets/imgs/onbording/onbord_one.jpg",
        img2: "assets/imgs/onbording/onbord_two.jpg",
        body1: "في أفضل تطبيق رياضي  ",
        body2: "لكرة القدم"),
    onBordingController(
        title: "مجتمع كبير!",
        img1: "assets/imgs/onbording/onbord_three.jpg",
        img2: "assets/imgs/onbording/onbord_foure.jpg",
        body1: "يضم التطبيق مجتمع كبير من\n المتابعين والمتفاعلين على\n الأخبار والمباريات",
        body2: "وهذا يعطي حياة للمباراة"),
  ];
}
