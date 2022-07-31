import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/box_messag/state.dart';
import 'package:beinmatch/model/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../controller/box_messag/cubit.dart';

class BoxMsg extends StatelessWidget {
  BoxMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoxMsgCubit()..startApp(),
      child: BlocConsumer<BoxMsgCubit, BoxMsgState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
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
              // actions: Components.appBarActions(
              //   context: context,
              //   color: Color(Config.primaryColor),
              // ),
              title: Text(
                ' الاشعارات',
                style: TextStyle(
                    color: Color(Config.secondaryColor),
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              color: Colors.white,
              child: LiquidPullToRefresh(
                color: Color(Config.primaryColor),
                springAnimationDurationInMilliseconds: 500,
                onRefresh: () {
                  return Future(() => BoxMsgCubit.get(context).startApp());
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
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
                        if (BoxMsgCubit.get(context).isReady)
                          msgList(context,
                              BoxMsgCubit.get(context).notifictionModel.data),
                        if (state is LoadingBoxMsgState)
                          Center(
                            child: CircularProgressIndicator(
                              color: Color(Config.primaryColor),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget msgList(context, List<NotifictionModel> msg) {
    if (msg.isEmpty) {
      return Center(
        child: Text(
          'لايوجد اشعارات !',
          style: TextStyle(
              color: Color(Config.primaryColor),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.separated(
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
                      msg[index].title!,
                      style: TextStyle(
                          color: Color(Config.secondaryColor),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      msg[index].content!,
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
    );
  }
}
