import 'package:foodapp/app/core.dart';

class AuthHttpService extends BaseApiClient {
  Future<BaseResp<dynamic>> login(
      {required String userName, required String password}) async {
    return request<LoginResp>(
      Method.post,
      AppApi.login,
      data: {
        "email": userName,
        "password": password,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return LoginResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> signUp(SignUpReq signUpReq) async {
    return request<dynamic>(
      Method.post,
      AppApi.register,
      data: signUpReq.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
