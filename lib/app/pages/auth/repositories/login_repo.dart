import 'package:foodapp/app/core.dart';

class LoginRepo extends ActiveRepo<String, LoginResp> {
  @override
  String get boxName => ModelTypeDefine.loginBox;
}
