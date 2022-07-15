import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/components/loader.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';


class MatchClubLoader extends StatelessWidget {
  MatchClubLoader({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:4,
                itemBuilder: (context, index) {
                  return Loader.LoaderData(
                    child: Components.matchesComponent(
                      
                      context: context,
                      logo1: "http://app.ahmadnahal.com/storage/upload/1655105561.jpg",
                      logo2: "http://app.ahmadnahal.com/storage/upload/1655105561.jpg",
                      name1: "",
                      name2: "",
                      statusMatch: '',
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}