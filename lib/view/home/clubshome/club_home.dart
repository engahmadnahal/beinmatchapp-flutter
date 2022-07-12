import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClubHome extends StatelessWidget {
  ClubHome({Key? key}) : super(key: key);
  List<Map<String, dynamic>> dawry = [
    {
      "id": 1,
      "dawry_id": "20",
      "name": "ريال مدريد",
      "avater": "https://www.yalla-shoot.com/images/upload/images/0011.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "26",
      "draw": "8",
      "game_over": "4",
      "difference": "49",
      "points": "86"
    },
    {
      "id": 2,
      "dawry_id": "20",
      "name": "برشلونة",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376868119.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "21",
      "draw": "10",
      "game_over": "7",
      "difference": "30",
      "points": "73"
    },
    {
      "id": 11,
      "dawry_id": "20",
      "name": "فالنسيا",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918203.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "11",
      "draw": "15",
      "game_over": "12",
      "difference": "-5",
      "points": "48"
    },
    {
      "id": 68,
      "dawry_id": "20",
      "name": "قادش",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1408045522.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "15",
      "game_over": "15",
      "difference": "-16",
      "points": "39"
    },
    {
      "id": 105,
      "dawry_id": "20",
      "name": "أوساسونا",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918041.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "12",
      "draw": "11",
      "game_over": "15",
      "difference": "-14",
      "points": "47"
    },
    {
      "id": 107,
      "dawry_id": "20",
      "name": "خيتافي",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918076.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "15",
      "game_over": "15",
      "difference": "-8",
      "points": "39"
    },
    {
      "id": 114,
      "dawry_id": "20",
      "name": "ريال بيتيس",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918123.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "19",
      "draw": "8",
      "game_over": "11",
      "difference": "22",
      "points": "65"
    },
    {
      "id": 121,
      "dawry_id": "20",
      "name": "سيلتا فيغو",
      "avater": "https://www.yalla-shoot.com/images/upload/images/98760.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "12",
      "draw": "10",
      "game_over": "16",
      "difference": "0",
      "points": "46"
    },
    {
      "id": 122,
      "dawry_id": "20",
      "name": "غرناطة",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918188.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "14",
      "game_over": "16",
      "difference": "-17",
      "points": "38"
    },
    {
      "id": 128,
      "dawry_id": "20",
      "name": "فياريال",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918216.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "16",
      "draw": "11",
      "game_over": "11",
      "difference": "26",
      "points": "59"
    },
    {
      "id": 130,
      "dawry_id": "20",
      "name": "ليفانتي",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918230.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "11",
      "game_over": "19",
      "difference": "-25",
      "points": "35"
    },
    {
      "id": 168,
      "dawry_id": "20",
      "name": "ديبورتيفو ألافيس",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1598965308.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "7",
      "game_over": "23",
      "difference": "-34",
      "points": "31"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        return LiquidPullToRefresh(
          color: Color(Config.primaryColor),
          springAnimationDurationInMilliseconds: 500,
          onRefresh: () {
            return Future(() => AppCubit.get(context).getClub());
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text(
                          'الفرق الرياضية',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(Config.primaryColor),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dawry.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: FadeInImage.assetNetwork(
                                            placeholder: Config.placeholderImage,
                                            image: '${AppCubit.get(context).clubs[index].avater}',
                                          ).image,
                                          radius: 25,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '${AppCubit.get(context).clubs[index].name}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(Config.primaryColor),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          }),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
