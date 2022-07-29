import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClubHome extends StatelessWidget {
  ClubHome({Key? key}) : super(key: key);

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
                        itemCount: AppCubit.get(context).clubs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Components.navigator(context: context, screen: SingleClub(AppCubit.get(context).clubs[index].id));
                            },
                            child: Container(
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
        );
      },

    );
  }
}
