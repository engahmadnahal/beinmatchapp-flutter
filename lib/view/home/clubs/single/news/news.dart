import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/model/club/single_club_model.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClubNews extends StatelessWidget {
  SingelClubModel clubModel;

  ClubNews(this.clubModel,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: LiquidPullToRefresh(
                color: Color(Config.primaryColor),
                springAnimationDurationInMilliseconds: 500,
                onRefresh: () {
                  return Future.delayed(
                      Duration(seconds: 2), () => print("Hello"));
                },
                child: newsList(context,clubModel),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //  TextButton(
          //   onPressed: () {
          //     print(_sroll);
          //   },
          //   child: Text("جلب المزيد",style: TextStyle(
          //     color: Color(Config.primaryColor),
          //     fontWeight: FontWeight.bold
          //   ),),
          // ),
        ],
      ),
    );
  }
  Widget newsList(context,SingelClubModel clubModel){
    if(clubModel.posts!.isEmpty){
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Text('للأسف ، لايوجد أخبار عن الفريق',style: TextStyle(
              color: Color(Config.primaryColor),
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),),
        ),
      );
    }
    return ListView.separated(
      physics: BouncingScrollPhysics(),

      itemCount: clubModel.posts!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Components.navigator(
                context: context,
                screen: NewsSingle(
                  post: clubModel.posts![index],
                ));
          },
          child: Components.post(
            context: context,
            image:
            "${clubModel.posts![index].thumnail}",
            title: "${clubModel.posts![index].title}",
            created_at:
            "${clubModel.posts![index].created_at}",
            tags:
            "${clubModel.posts![index].dawry!.name}",
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
    );
  }
}