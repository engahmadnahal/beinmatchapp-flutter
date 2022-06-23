import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components {

  static ScaffoldFeatureController snakBar({@required var context,String? text,Color? color}){
     SnackBar snackBar = SnackBar(
      content: Text("$text"),
      backgroundColor: color,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static Future navigator({@required var context, @required var screen}) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Widget textButton({
    @required String? text,
    @required Function()? onPressed,
    double w = 134,
    double h = 41,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all(
          Size(w, h),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        )),
        backgroundColor: MaterialStateProperty.all(
          Color(Config.primaryColor),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      child: Text(
        "$text",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
