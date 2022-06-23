import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/onbording/onbordingdatapageview.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingPage extends StatelessWidget {
  OnBordingPage({Key? key}) : super(key: key);

  PageController bordPage = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1.0,
  );
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()  {
               SheardHelper.setBool("skipBord", true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthLogin()));
            },
            child: Text(
              'تخطي',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(Config.primaryColor),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: bordPage,
                  onPageChanged: (index) {
                    currentPage = index;
                  },
                  itemCount: Config.onbordData.length,
                  itemBuilder: (context, i) => onBordData(i)),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordPage,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    activeDotColor: Color(Config.primaryColor),
                    spacing: 5.0,
                  ),
                  count: Config.onbordData.length,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (currentPage == 1) {
                      SheardHelper.setBool("skipBord", true);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuthLogin()));
                    } else {
                      bordPage.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(Config.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
