import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/components/loader.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClubNewsLoader extends StatelessWidget {
  ClubNewsLoader({Key? key}) : super(key: key);
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
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Loader.LoaderData(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black38,
                                ),
                                // width: MediaQuery.of(context).size.width - 20,
                                width: 120,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                color: Config.baseColor,

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    color: Config.baseColor,

                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 15,
                                    color: Config.baseColor,

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
         
        ],
      ),
    );
  }
}