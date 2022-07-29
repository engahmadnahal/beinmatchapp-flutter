import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ErrorGetData extends StatefulWidget {
  const ErrorGetData({Key? key}) : super(key: key);

  @override
  State<ErrorGetData> createState() => _ErrorGetDataState();
}

class _ErrorGetDataState extends State<ErrorGetData> {

  bool _connection = false;
  @override
  void initState() async {
       _connection = await InternetConnectionChecker().hasConnection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          _connection == false ? "لايوجد اتصال في الانترنت !"
          : "حدث خطأ ، حاول مرة اخرى"
          ,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(Config.primaryColor)
        ),),
      ),
    );
  }
}