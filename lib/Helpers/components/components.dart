import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/home/main/cubit.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/view/box_message/box_message.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components {
  static List<Widget>? appBarActions({
    required context,
    var color,
  }) =>
      [
        IconButton(
          onPressed: () {
            navigator(context: context, screen: Search());
          },
          icon: const Icon(Icons.search),
          color: color ??= Color(Config.primaryColor),
        ),
        IconButton(
          onPressed: () {
            navigator(context: context, screen: BoxMsg());
          },
          icon: const Icon(Icons.notification_add_outlined),
          color: color ??= Color(Config.primaryColor),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).openDrawer(context);
          },
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
                child: Components.customeImage(
                  url: image,
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '$created_at',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$tags',
                    style: const TextStyle(
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
      {required var context, String? text, Color? color}) {
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

  static Future navigatorReplace({@required var context, @required var screen}) {
    return Navigator.pushReplacement(
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
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
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
        style: const TextStyle(
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
    try {
      imgWidget = FadeInImage(
        width: w ??= double.infinity,
        height: h ??= double.infinity,
        fit: BoxFit.cover,
        placeholder: AssetImage(Config.placeholderImage),
        image: NetworkImage(
          url!,
        ),
      );
    } catch (error) {
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

  static Widget matchesComponent(
      {required context,
      required logo1,
      required logo2,
      required name1,
      required name2,
      required statusMatch}) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: FadeInImage.assetNetwork(
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: Config.placeholderImage,
                    image: logo1,
                  ).image,
                  radius: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name1,
                  style: TextStyle(
                      color: Color(Config.primaryColor),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              color: Color(Config.primaryColor),
              child: Center(
                child: Text(
                  statusMatch,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  name2,
                  style: TextStyle(
                      color: Color(Config.primaryColor),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: FadeInImage.assetNetwork(
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: Config.placeholderImage,
                    image: logo2,
                  ).image,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget tableViewData({
    required String? orderd,
    required String? name,
    required String? logo,
    required String? playing,
    required String? woner,
    required String? draw,
    required String? gameOver,
    required String? defirance,
    required String? points,
    dynamic color = Colors.white,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$orderd',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FadeInImage(
                      placeholder: AssetImage(Config.placeholderImage),
                      image: NetworkImage('$logo'),
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      '$name',
                      style: TextStyle(
                          color: Color(Config.primaryColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            flex: 1,
            child: Text(
              '$playing',
              style: TextStyle(
                  color: Color(Config.primaryColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$woner',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$draw',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$gameOver',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$defirance',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$points',
                style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
