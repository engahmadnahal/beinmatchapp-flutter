import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';

import '../../Helpers/end_point/api.dart';
class BlockScreen extends StatefulWidget {
  const BlockScreen({Key? key}) : super(key: key);

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/default_avater.png',width: 150,),
            SizedBox(height: 50,),
            Text('لأسباب ما تم حذف حسابك او حظره من قبل الادارة !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(Config.primaryColor)
              ),),

            SizedBox(height: 25,),

            Components.textButton(text: " الخروج ", onPressed: (){
              RequstApi.logout(context);
            }),
          ],
        ),
      ),
    );
  }
}
