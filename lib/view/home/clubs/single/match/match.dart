import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';


class MatchClub extends StatelessWidget {
   MatchClub({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
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
                    height: 15,
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}