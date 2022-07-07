import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/view/home/clubs/single/dawry/dawry.dart';
import 'package:beinmatch/view/home/clubs/single/match/match.dart';
import 'package:beinmatch/view/home/clubs/single/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleClub extends StatelessWidget {
  int? cubId;
   SingleClub(this.cubId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              PreferredSize(
                preferredSize:
                    Size.fromWidth(MediaQuery.of(context).size.width),
                child: SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 3 + 30,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(Config.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: Components.appBarActions(
                    context: context,
                    color: Color(Config.primaryColor),
                  ),
                  title: Text(
                    'ريال مدريد',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(Config.secondaryColor),
                      fontSize: 20,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'الترتيب',
                          style: TextStyle(
                              color: Color(Config.primaryColor),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'المباريات',
                          style: TextStyle(
                              color: Color(Config.primaryColor),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'الأخبار',
                          style: TextStyle(
                              color: Color(Config.primaryColor),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  flexibleSpace: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_outline,
                                      size: 30,
                                      color: Color(Config.primaryColor),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: FadeInImage(
                                          placeholder: AssetImage(Config.placeholderImage),
                                          image: NetworkImage(
                                              'https://www.yalla-shoot.com/images/upload/images/0011.png'),
                                        ).image,
                                        radius: 80,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Container(
                        //     child: Text(
                        //       'ريال مدريد',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(Config.secondaryColor),
                        //         fontSize: 20,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      DawryClub(),
                      MatchClub(),
                      ClubNews(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
