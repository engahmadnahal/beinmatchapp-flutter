import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Color(Config.primaryColor),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'تواصل معنا',
          style: TextStyle(
            color: Color(Config.secondaryColor),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: Components.appBarActions(context: context),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () => print("Hello"));
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      'ارسل لنا رسالة',
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
                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image(image: AssetImage('assets/imgs/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'الرسالة',
                        labelStyle: TextStyle(
                          color: Color(Config.primaryColor),
                          fontSize: 20,
                        ),
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Components.textButton(
                    text: 'ارسال',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('نرجوا ان تكون الرسالة لسبب من الاتي ',
                  style: TextStyle(
                    color: Color(Config.secondaryColor),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مشكلة واجهتك في التطبيق',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'خطأ برمجي ظهر في التطبيق وتريد الإبلاغ عنه',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ميزة ترغب في ان تتواجد في التحديثات القادمة',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                    
                      ],
                    ),
                  ),
                 SizedBox(
                    height: 30,
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
