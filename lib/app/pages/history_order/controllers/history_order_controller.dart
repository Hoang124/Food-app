import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class HistoryOrderController extends GetxController {
  late UserOrderService _userOrderService;

  List<OrderResponse>? orderResponseList;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _userOrderService = Get.find<UserOrderService>();
    super.onInit();
  }

  @override
  void onReady() {
    getUserOrder().then((value) => isLoading = true);
    super.onReady();
  }

  Future<void> getUserOrder() async {
    final result = await _userOrderService.getUserOrder(1, 30);
    if (result.isSuccess() && result.data != null) {
      orderResponseList = result.data ?? [];
    }
  }

  String getDateTime(int miliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(miliseconds);
    String formattedDateTime = DateFormat('dd/MM/yyyy hh:mm').format(date);
    return formattedDateTime;
  }
    bool checkTimeButtonFeedback(int timeOrder){
        final now = DateTime.now();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeOrder);

  final difference = now.difference(dateTime);

  return difference.inDays <= 1;

  }
}
