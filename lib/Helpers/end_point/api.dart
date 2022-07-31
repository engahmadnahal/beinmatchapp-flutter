import '../../view/auth/auth_login.dart';
import '../DioHelper.dart';
import '../components/components.dart';
import '../sheard_prefrancess.dart';

class RequstApi{

  static logout(context) async {
    var response = await DioHelper.postData(url: 'user/logout', data: {});
    if(response!.statusCode == 200){
      await SheardHelper.removeData('userInfo');
      Components.navigatorReplace(context: context, screen: AuthLogin());

    }
  }
}