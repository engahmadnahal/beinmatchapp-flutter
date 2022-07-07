import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class BoxMsg extends StatelessWidget {
  BoxMsg({Key? key}) : super(key: key);

List<Map<String,dynamic>> msg = [
  {
    'title':'بداية كأس العالم',
    'body':'شاهد الان بداية كاس العالم',
  },
    {
      'title': 'خسارة مدوية',
      'body': 'خسارة فريق ريال مدريد امام ليفربول',
    },
        {
      'title': 'فوز باكتساح',
      'body': 'فاز اليوم فريق فلسطين بكأس العالم',
    },
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
          ' الاشعارات',
          style: TextStyle(
              color: Color(Config.secondaryColor), fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: LiquidPullToRefresh(
          color: Color(Config.primaryColor),
          springAnimationDurationInMilliseconds: 500,
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () => print("Hello"));
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'صندوق الاشعارات',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(Config.primaryColor)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: msg.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(
                                  Icons.notifications_active_outlined,
                                  color: Color(Config.primaryColor),
                                  size: 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${msg[index]["title"]}',
                                    style: TextStyle(
                                        color: Color(Config.secondaryColor),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${msg[index]["body"]}',
                                    style: TextStyle(
                                        color: Color(Config.primaryColor),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 1,
                        color: Color(Config.unActiveColor),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
