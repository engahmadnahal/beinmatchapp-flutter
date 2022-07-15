import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/model/club/single_club_model.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:flutter/material.dart';

class DawryClub extends StatelessWidget {

  SingelClubModel clubModel;
  DawryClub(this.clubModel,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Base Top Table For Dawry
          Container(
            color: Color(Config.primaryColor),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'ت',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      'الفريق',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'ل',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'ف',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'ت',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'خ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'الفرق',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'النقاط',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Data For Dawry
          Container(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: clubModel.clubs!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Components.navigator(context: context, screen: SingleClub(clubModel.clubs![index].id));
                  },
                  child: Components.tableViewData(
                      color: clubModel.clubs![index].id == clubModel.id ? Color(Config.secondaryColor) : Colors.white,
                      orderd: "${index + 1}",
                      name: clubModel.clubs![index].name,
                      logo: clubModel.clubs![index].avater,
                      playing: clubModel.clubs![index].playing,
                      woner: clubModel.clubs![index].have_won,
                      draw: clubModel.clubs![index].draw,
                      gameOver: clubModel.clubs![index].game_over,
                      defirance: clubModel.clubs![index].difference,
                      points: clubModel.clubs![index].points),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1,
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
