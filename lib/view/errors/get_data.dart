import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';

class ErrorGetData extends StatelessWidget {
  const ErrorGetData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("حدث خطأ ، حاول مرة اخرى",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(Config.primaryColor)
        ),),
      ),
    );
  }
}