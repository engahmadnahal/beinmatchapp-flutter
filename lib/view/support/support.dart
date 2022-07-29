import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/support/states.dart';
import 'package:beinmatch/view/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/support/cubit.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  var msgController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SupportCubit(),
      child: BlocConsumer<SupportCubit,SupportState>(
        listener: (context,state) {},
        builder: (context,state){
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
              // actions: Components.appBarActions(context: context),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height,
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
                      key: formKey,
                      child: TextFormField(
                        controller: msgController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "لايمكنك ارسال رسالة فارغة";
                          }
                        },
                        maxLength: 100,
                        maxLines: 3,
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
                    if(state is LoadingSupportState)
                      Container(
                        width: 20,
                        height: 20,
                          child: CircularProgressIndicator(color: Color(Config.primaryColor),strokeWidth: 2.0,)),
                    if(state is! LoadingSupportState)
                        Components.textButton(
                      text: 'ارسال',
                      onPressed: () async {
                        if(formKey.currentState!.validate()){
                          await SupportCubit.get(context).sendMessage(msgController.value.text);
                          Components.navigatorReplace(context: context, screen: SettingScreen());
                        }
                      },
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
          );
        },
      ),
    );
  }
}
