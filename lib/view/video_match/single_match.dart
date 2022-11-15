import 'dart:io';

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/video/cubit.dart';
import 'package:beinmatch/controller/video/states.dart';
import 'package:beinmatch/model/match/match_model.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleMatch extends StatefulWidget {
  MatchModel match;

  SingleMatch(this.match, {Key? key}) : super(key: key);

  @override
  State<SingleMatch> createState() => _SingleMatchState();
}

class _SingleMatchState extends State<SingleMatch> {
  var scafullKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  ScrollController commentListControaller = ScrollController();
  late String _video;
  late WebViewController _controllerWeb;
  @override
  void initState() {
    // TODO: implement initState
    //  if (Platform.isAndroid) WebView.platform = AndroidWebView();
    _video = widget.match.channel!.channel_url!.urls![0];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    comment.dispose();
    commentListControaller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return BlocProvider(
      create: (context) => VideoCubit()..startApp(widget.match),
      child: BlocConsumer<VideoCubit, VideoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scafullKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Color(Config.primaryColor),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    scafullKey.currentState!.showBottomSheet((context) =>
                        settingVideoButtomSheet(
                            context, widget.match.channel!.channel_url!.urls!));
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 25,
                    color: Color(Config.primaryColor),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: WebView(
                          initialUrl:
                              _video,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (controller) {
                            _controllerWeb = controller;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Components.navigator(
                                    context: context,
                                    screen:
                                        SingleClub(widget.match.club_one!.id));
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                child: Image(
                                  image: NetworkImage(
                                      '${widget.match.club_one!.logo}'),
                                ),
                              ),
                            )),
                            // Expanded(
                            //   flex: 1,
                            //   child: CircleAvatar(
                            //     radius: 44,
                            //     backgroundColor: Colors.grey[300],
                            //     backgroundImage: Image(
                            //       image:
                            //           NetworkImage('${match.club_one!.logo}'),
                            //       width: 15,
                            //       height: 15,
                            //     ).image,
                            //   ),
                            // ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            VideoCubit.get(context).sendPoll(
                                                widget.match.id!,
                                                one: true,
                                                draw: false,
                                                two: false);
                                          },
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: VideoCubit.get(context)
                                                  .colorPoll('one'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            padding: const EdgeInsets.only(
                                                right: 20,
                                                top: 6,
                                                bottom: 6,
                                                left: 20),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              "فوز",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: VideoCubit.get(context)
                                                      .colorTextPoll('one'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${VideoCubit.get(context).numPollOnePersant}%",
                                          style: TextStyle(
                                              color:
                                                  Color(Config.primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            VideoCubit.get(context).sendPoll(
                                                widget.match.id!,
                                                one: false,
                                                draw: true,
                                                two: false);
                                          },
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: VideoCubit.get(context)
                                                  .colorPoll('draw'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            padding: EdgeInsets.only(
                                                right: 15,
                                                top: 6,
                                                bottom: 6,
                                                left: 15),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              "ت",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: VideoCubit.get(context)
                                                      .colorTextPoll('draw'),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${VideoCubit.get(context).numPollDrawPersant}%",
                                          style: TextStyle(
                                              color: Colors.green[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            VideoCubit.get(context).sendPoll(
                                                widget.match.id!,
                                                one: false,
                                                draw: false,
                                                two: true);
                                          },
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: VideoCubit.get(context)
                                                  .colorPoll('two'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            padding: EdgeInsets.only(
                                                right: 20,
                                                top: 6,
                                                bottom: 6,
                                                left: 20),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "فوز",
                                              style: TextStyle(
                                                  color: VideoCubit.get(context)
                                                      .colorTextPoll('two'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${VideoCubit.get(context).numPollTwoPersant}%",
                                          style: TextStyle(
                                              color:
                                                  Color(Config.secondaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Components.navigator(
                                    context: context,
                                    screen:
                                        SingleClub(widget.match.club_two!.id));
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                child: Image(
                                  image: NetworkImage(
                                      '${widget.match.club_two!.logo}'),
                                ),
                              ),
                            )),
                            // Expanded(
                            //   flex: 1,
                            //   child: CircleAvatar(
                            //     radius: 44,
                            //     backgroundColor: Colors.grey[300],
                            //     backgroundImage: Image(
                            //       image:
                            //           NetworkImage('${match.club_two!.logo}'),
                            //       width: 15,
                            //       height: 15,
                            //     ).image,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width - 50,
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "التعليقات",
                                style: TextStyle(
                                    color: Color(Config.primaryColor),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      VideoCubit.get(context)
                                          .sendLike(widget.match.id, 1);
                                    },
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color: VideoCubit.get(context)
                                              .isActive('like') ??
                                          VideoCubit.get(context).colorBtn,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      VideoCubit.get(context)
                                          .sendLike(widget.match.id, 0);
                                    },
                                    icon: Icon(
                                      Icons.thumb_down,
                                      color: VideoCubit.get(context)
                                              .isActive('dislike') ??
                                          VideoCubit.get(context).colorBtn,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: commentList(
                              VideoCubit.get(context).commentMatch,
                              VideoCubit()),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: comment,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء كتابة تعليق !';
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      VideoCubit.get(context).sendComment(
                                          widget.match.id!, comment.value.text);
                                      comment.text = "";
                                    }
                                  },
                                  icon: Icon(Icons.send_outlined,
                                      color: Color(Config.primaryColor))),
                              hintText: 'علق الأن',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget settingVideoButtomSheet(context, List<String> channelList) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 0.4),
              blurRadius: 25,
              spreadRadius: 25,
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)),
                width: MediaQuery.of(context).size.width / 9,
                height: 5,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "الإعدادات",
                    style: TextStyle(
                        color: Color(Config.secondaryColor),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      VideoCubit.get(context).startApp(widget.match);
                    },
                    icon: Icon(
                      Icons.refresh_outlined,
                      color: Color(Config.primaryColor),
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                // VideoCubit.get(context).changVideo(channelList[0]);
                setState(() {
                  _video = channelList[0];
                  _controllerWeb.loadUrl(_video);
                });
                scafullKey.currentState!.showBottomSheet((context) => Container(
                      height: 0,
                      width: 0,
                    ));
              },
              child: Text(
                "الفيديو الأول",
                style: TextStyle(
                    color: _video == channelList[0]
                        ? Color(Config.secondaryColor)
                        : Color(Config.primaryColor),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                // VideoCubit.get(context).changVideo(channelList[1]);
                setState(() {
                  _video = channelList[1];
                  _controllerWeb.loadUrl(_video);

                });
                scafullKey.currentState!.showBottomSheet((context) => Container(
                      height: 0,
                      width: 0,
                    ));
              },
              child: Text(
                "الفيديو الثاني",
                style: TextStyle(
                    color: _video == channelList[1]
                        ? Color(Config.secondaryColor)
                        : Color(Config.primaryColor),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                // VideoCubit.get(context).changVideo(channelList[2]);
                setState(() {
                  _video = channelList[2];
                  _controllerWeb.loadUrl(_video);

                });
                scafullKey.currentState!.showBottomSheet((context) => Container(
                      height: 0,
                      width: 0,
                    ));
              },
              child: Text(
                "الفيديو الثالث",
                style: TextStyle(
                    color: _video == channelList[2]
                        ? Color(Config.secondaryColor)
                        : Color(Config.primaryColor),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Link(
              uri: Uri.parse(Config.website_url),
              target: LinkTarget.blank,
              builder: (context, followLink) => InkWell(
                onTap: followLink,
                child: Text(
                  ".. مشاهدة على الموقع ..",
                  style: TextStyle(
                      color: Color(Config.primaryColor),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commentList(Comments? comment, VideoCubit state) {
    if (state is LoadingSendCommentMatchState ||
        state is LoadingUpdateCommentMatchState ||
        state is LoadingGetCommentMatchState ||
        state is LoadingDeleteCommentMatchState) {
      return Center(
        child: CircularProgressIndicator(
          color: Color(Config.primaryColor),
        ),
      );
    }

    /// this if cond , solution error null checker in listView
    if (comment == null || comment.data.length == 0) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Text(
          'لايوجد اي تعليقات',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(Config.primaryColor)),
        )),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      controller: commentListControaller,
      // reverse: true,
      itemCount: comment.data.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: FadeInImage(
                image: NetworkImage(comment.data[index].user!.avater ??
                    'http://app.ahmadnahal.com/assets/img/upload/media/login.png'),
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/imgs/default_avater.png'),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${comment.data[index].user!.name}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "${coment.data[index].}",
                    //   style: TextStyle(
                    //     fontSize: 11,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('${comment.data[index].content}',
                    style: const TextStyle(fontSize: 15, color: Colors.black)),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
