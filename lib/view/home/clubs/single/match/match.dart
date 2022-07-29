import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/model/club/single_club_model.dart';
import 'package:flutter/material.dart';

import '../../../../video_match/single_match.dart';


class MatchClub extends StatelessWidget {
  SingelClubModel clubModel;

  MatchClub(this.clubModel,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                matchList(context,clubModel),

            // InkWell(
            //   onTap: (){
            //     Components.navigator(context: context, screen: SingleMatch(clubModel));
            //   },
            //     child: matchList(context,clubModel)
            // ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget matchList(context,SingelClubModel clubModel){
    if(clubModel.matches!.isEmpty){
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Text('للأسف ، لايوجد مباريات مجدولة للفريق',style: TextStyle(
              color: Color(Config.primaryColor),
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),),
        ),
      );
    }
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: clubModel.matches!.length,
      itemBuilder: (context, index) {
        return Components.matchesComponent(
          context: context,
          logo1: clubModel.matches![index].club_one!.logo,
          logo2: clubModel.matches![index].club_two!.logo,
          name1: clubModel.matches![index].club_one!.name,
          name2: clubModel.matches![index].club_two!.name,
          statusMatch: clubModel.matches![index].timeStart!.substring(11,16),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }
}