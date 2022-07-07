import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:flutter/material.dart';

class MatchHome extends StatelessWidget {
  MatchHome({Key? key}) : super(key: key);

  List<Map<String, dynamic>> matches = [
    {
      "id": 1,
      "botola": "2",
      "timeStart": "2022-01-11 21:05:00",
      "likes": 0,
      "dislikes": 0,
      "poll_to_club_one": 0,
      "poll_to_club_two": 0,
      "poll_to_darw": 0,
      "club_one": {
        "id": "1",
        "name": "ريال مدريد",
        "logo": "https://www.yalla-shoot.com/images/upload/images/0011.png"
      },
      "club_two": {
        "id": "2",
        "name": "برشلونة",
        "logo":
            "https://www.yalla-shoot.com/images/upload/images/1376868119.png"
      },
      "dawry": {
        "id": 2,
        "name": "دوري أبطال أوروبا",
        "avater":
            "https://www.yallakora.com/pictures/Tourlogo/UEFAChampionsLeague30-7-2018-14-58-54.png"
      },
      "channel": {
        "id": 1,
        "channel_name": "بين سبورت 1",
        "channel_url": {"one": "الاول", "two": "الثاني", "three": "الثالث"}
      },
      "poll": [],
      "comments": {"count": 0, "data": []}
    },
    {
      "id": 2,
      "botola": "2",
      "timeStart": "2022-01-07 01:30:00",
      "likes": 0,
      "dislikes": 0,
      "poll_to_club_one": 0,
      "poll_to_club_two": 0,
      "poll_to_darw": 0,
      "club_one": {
        "id": "2",
        "name": "برشلونة",
        "logo":
            "https://www.yalla-shoot.com/images/upload/images/1376868119.png"
      },
      "club_two": {
        "id": "4",
        "name": "تشيلسي",
        "logo": "https://www.yalla-shoot.com/images/upload/images/889110.png"
      },
      "dawry": {
        "id": 2,
        "name": "دوري أبطال أوروبا",
        "avater":
            "https://www.yallakora.com/pictures/Tourlogo/UEFAChampionsLeague30-7-2018-14-58-54.png"
      },
      "channel": {
        "id": 2,
        "channel_name": "بين سبورت 2",
        "channel_url": {"one": "الاول", "two": "الثاني", "three": "الثالث"}
      },
      "poll": [],
      "comments": {"count": 0, "data": []}
    },
    {
      "id": 3,
      "botola": "19",
      "timeStart": "2022-01-10 21:05:00",
      "likes": 0,
      "dislikes": 0,
      "poll_to_club_one": 0,
      "poll_to_club_two": 0,
      "poll_to_darw": 0,
      "club_one": {
        "id": "5",
        "name": "توتنهام",
        "logo":
            "https://www.yalla-shoot.com/images/upload/images/1376917385.png"
      },
      "club_two": {
        "id": "3",
        "name": "آرسنال",
        "logo":
            "https://www.yalla-shoot.com/images/upload/images/1376917301.png"
      },
      "dawry": {
        "id": 19,
        "name": "الدوري الإنجليزي",
        "avater":
            "https://www.yallakora.com/pictures/Tourlogo/PremierLeague30-7-2018-14-34-0.png"
      },
      "channel": {
        "id": 3,
        "channel_name": "بين سبورت 3",
        "channel_url": {"one": "الاول", "two": "الثاني", "three": "الثالث"}
      },
      "poll": [],
      "comments": {"count": 0, "data": []}
    }
  ];

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
    return SingleChildScrollView(
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
                  width: MediaQuery.of(context).size.width / 3,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(Config.primaryColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          DateTime.now().toString().substring(0, 10),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return Components.matchesComponent(
                      context: context,
                      logo1: matches[index]["club_one"]["logo"],
                      logo2: matches[index]["club_two"]["logo"],
                      name1: matches[index]["club_one"]["name"],
                      name2: matches[index]["club_two"]["name"],
                      statusMatch: 'مباشر',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
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
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Components.navigator(context: context, screen: SingleClub(dawry[index]['id']));
                          },
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.network(
                                    dawry[index]['avater'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      dawry[index]['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                      itemCount: dawry.length),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
