import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components {
  static List<Widget>? appBarActions({
    var color,
  }) =>
      [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: color ??= Color(Config.primaryColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notification_add_outlined),
          color: color ??= Color(Config.primaryColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: color ??= Color(Config.primaryColor),
        ),
      ];
  static Widget post({
    required context,
    @required String? image,
    @required String? title,
    @required String? created_at,
    @required String? tags,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Components.customeImage(url: image,
                  w: MediaQuery.of(context).size.width / 3,
                  h: 120,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38,
                ),
                // width: MediaQuery.of(context).size.width - 20,
                width: MediaQuery.of(context).size.width / 3,
                height: 120,
                clipBehavior: Clip.antiAlias,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '$created_at',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$tags',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static ScaffoldFeatureController snakBar(
      {@required var context, String? text, Color? color}) {
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

  static Widget customeImage({
    @required String? url,
    double? w,
    double? h,
  }) {

    dynamic imgWidget;
    try{
      imgWidget = FadeInImage(
        width: w ??= double.infinity,
        height: h ??= double.infinity,
        fit: BoxFit.cover,
        placeholder: AssetImage(Config.placeholderImage),
        image: NetworkImage(
          '${url}',
        ),
      );
    }catch(error){
      FadeInImage(
        width: w ??= double.infinity,
        height: h ??= double.infinity,
        fit: BoxFit.cover,
        placeholder: AssetImage(Config.placeholderImage),
        image: AssetImage(Config.placeholderImage),
      );
    }
    return imgWidget;
  }
}
