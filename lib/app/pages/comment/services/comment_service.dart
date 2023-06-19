import 'package:foodapp/app/core.dart';

class CommentHttpService extends BaseApiClient {
  Future<BaseResp<List<CommentModel>>> getCommentByFoodId(int id) async {
    return request<List<CommentModel>>(
      Method.get,
      AppApi.getCommentByFoodId,
      queryParameters: {
        "foodId": id,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
