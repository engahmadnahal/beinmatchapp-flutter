
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/auth/login/cubit.dart';
import 'package:beinmatch/controller/auth/login/states.dart';
import 'package:beinmatch/view/auth/auth_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLogin extends StatelessWidget {
   AuthLogin({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController email =  TextEditingController();
  TextEditingController password =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener :(context,state) {},
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Color(Config.primaryColor),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset("assets/imgs/logo.png"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')){
                                  return 'البريد الالكتروني غير صالحة';
                                }
                              },
                              onChanged: (value){
                                
                              },
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
                              controller : password,
                              validator: (value){
                                if(value!.isEmpty || value.length < 6) {
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
                                Components.textButton(text: "الذهاب", onPressed: () {
                                  LoginCubit.get(context).login(context,formKey,email.value.text,password.value.text);
                                }),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    print("Forgit Password");
                                  },
                                  child: Text(
                                    "نسيت كلمة المرور؟",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(Config.primaryColor)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
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
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ليس لدي حساب",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(Config.secondaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Components.navigator(context: context, screen: AuthSignUp());
                                    },
                                    child: Text(
                                      "سجل الأن ؟",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(Config.primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
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
