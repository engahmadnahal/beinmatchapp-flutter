import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/onbording.dart';
import 'package:flutter/material.dart';

class onBordData extends StatelessWidget {
  int? index;
  onBordData(int index, {Key? key}) : super(key: key) {
    this.index = index;
  }

  List<onBordingController> data = Config.onbordData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              data[index!].title!,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(Config.secondaryColor),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.only(right: 20),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        height: 182,
                        width: 324,
                        image:
                            AssetImage(data[index!].img1!),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(Config.primaryColor).withOpacity(.3),
                      ),
                      clipBehavior: Clip.antiAlias,
                      height: 182,
                      width: 324,
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(right: 80, top: 130),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        height: 182,
                        width: 273,
                        image:
                            AssetImage(data[index!].img2!),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(Config.primaryColor).withOpacity(.3),
                      ),
                      clipBehavior: Clip.antiAlias,
                      height: 182,
                      width: 273,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              data[index!].body1!,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(Config.primaryColor),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              data[index!].body2!,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(Config.secondaryColor),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
