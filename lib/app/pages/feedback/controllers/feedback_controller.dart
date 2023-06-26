import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class FeedbackController extends GetxController {
  late final int _bikeFallCount;
  late double _star;
  final _isShowFeedback = false.obs;

  get bikeFallCount => _bikeFallCount;
  get star => _star;
  set star(value) => _star = value;
  get isShowFeedback => _isShowFeedback.value;
  set isShowFeedback(value) => _isShowFeedback.value = value;

  TextEditingController reasonController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  @override
  void onInit() {
 
    _star = 5;
    super.onInit();
  }


}
