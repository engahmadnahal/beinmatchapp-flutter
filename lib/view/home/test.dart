import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

String? token = SheardHelper.getData('token');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Token User For Test"),
            Text(" $token"),
            MaterialButton(onPressed: (){
              SheardHelper.removeData('token');
              Components.navigator(context: context, screen: AuthLogin());
            },
            child: Text("Logout"),),
          ],
        ),
      ),
    );
  }
}