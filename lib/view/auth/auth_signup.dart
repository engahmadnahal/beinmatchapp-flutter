import 'dart:io';

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/auth/signup/cubit.dart';
import 'package:beinmatch/controller/auth/signup/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignUp extends StatelessWidget {
  AuthSignUp({Key? key}) : super(key: key);
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                  
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'التسجيل',
                        style: TextStyle(
                          color: Color(Config.primaryColor),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: fname,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "الاسم الأول غير صالح";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'الاسم الاول',
                                  suffixIcon: Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color(Config.primaryColor),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Color(Config.primaryColor),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: lname,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "الاسم الثاني غير صالح";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'الاسم الثاني',
                                  
                                  suffixIcon: Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color(Config.primaryColor),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Color(Config.primaryColor),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: email,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'البريد الالكتروني غير صالحة';
                                  }
                                },
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'البريد الالكتروني',
                                  suffixIcon: Icon(
                                    Icons.email,
                                    size: 20,
                                    color: Color(Config.primaryColor),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Color(Config.primaryColor),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return 'كلمة المرور غير صالحة';
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'كلمة المرور',
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Color(Config.primaryColor),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Color(Config.primaryColor),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  if(state is SignUpLoading)
                                    Container(width: 20,height: 20,child: CircularProgressIndicator(color: Color(Config.primaryColor),strokeWidth: 2.0,)),
                                  if(state is! SignUpLoading)
                                  Components.textButton(
                                    text: "تسجيل الأن",
                                    w: 180,
                                    onPressed: () {
                                      SignUpCubit.get(context).signUp(
                                          context,
                                          formKey,
                                          fname.value.text,
                                          lname.value.text,
                                          email.value.text,
                                          password.value.text,
                                        Platform.isAndroid ? "Android" : "IOS"
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "لماذا اسجل في التطبيق ؟",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(Config.primaryColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "تسجل في التطبيق لتتمكن من التصويت والتعليق على \nالمباريات والأخبار الرياضية واضافة الفرق \nالى المفضلة الخاصة بك ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFB9B9B9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ),
                      ),
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
