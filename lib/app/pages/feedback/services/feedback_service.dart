

import 'package:foodapp/app/core.dart';

class FeeadbackService extends BaseApiClient {
  Future<BaseResp<dynamic>> feedback(FeedbackRequest feedbackRequest) async {
    return request<dynamic>(
      Method.post,
      AppApi.feedback,
      data: feedbackRequest.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
