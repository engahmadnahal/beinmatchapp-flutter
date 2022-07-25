import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class Loader{
  static dynamic LoaderData({
    @required Widget? child
  }){
    return Shimmer.fromColors(
      baseColor: Config.baseColor,
        highlightColor: Config.highlightColor,
        child: child!);
  }
}