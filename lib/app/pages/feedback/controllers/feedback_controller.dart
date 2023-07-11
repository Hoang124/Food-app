import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class FeedbackController extends GetxController {
  late double _star;
  final _isShowFeedback = false.obs;

  get star => _star;
  set star(value) => _star = value;
  get isShowFeedback => _isShowFeedback.value;
  set isShowFeedback(value) => _isShowFeedback.value = value;
  late FeeadbackService _feeadbackService;

  TextEditingController feedbackController = TextEditingController();
  int? foodID;

  @override
  void onInit() {
    _feeadbackService = Get.find<FeeadbackService>();
    if (Get.arguments != null && Get.arguments is int) {
      foodID = Get.arguments as int;
    }
    _star = 5;
    super.onInit();
  }

  Future<void> feedbackClick() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    FeedbackRequest feedbackRequest = FeedbackRequest(
      comment: feedbackController.text,
      foodId: foodID,
      rate: star.toInt(),
    );
    final result = await _feeadbackService.feedback(feedbackRequest);
    if (result.isSuccess()) {
      processingDialog.show();
      Get.offAllNamed(Routes.home);
    }
    processingDialog.show();
    SnackBars.error(message: "FeedBack Error");
  }
}
