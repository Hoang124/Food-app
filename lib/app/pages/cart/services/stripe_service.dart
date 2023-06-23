import 'package:dio/dio.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService extends BaseApiClient {
  void _init() {
    Stripe.publishableKey =
        "pk_test_51NLGRkBxRkUOTkLd80y5ecRlnd8ABrdQWbrdzqQY4neH7gmaU1IHE9l3MJ5hOATfOp1TjSzUmUC7dUUlovyZWP1200bESBEscJ";
  }

  Future<void> payment(String userID, int money) async {
    _init();
    await _createCustomer(userID);
    final paymentIntent = await _createPaymentIntents(userID, money);
    await _createCreditCard(
      userID,
      paymentIntent.data['client_secret'],
    );
  }

  Map<String, dynamic> getHeader() {
    String secretKey =
        "sk_test_51NLGRkBxRkUOTkLdLAkErcANIf2IPZW1aHFT1A3Bp9VsegKEX1zVxAbvbqov7YNUGkXU8K9eObobY5QevnixudSN00xfOAwb1M";
    Map<String, String> headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    return headers;
  }

  Future<BaseResp<dynamic>> _createCustomer(String userID) async {
    String url = 'https://api.stripe.com/v1/customers';

    return request<dynamic>(
      Method.post,
      url,
      options: Options(headers: getHeader()),
      data: {'description': userID},
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> _createPaymentIntents(
      String customer, int money) async {
    String url = 'https://api.stripe.com/v1/payment_intents';
    Map<String, dynamic> body = {
      "currency": "vnd",
      "payment_method_types[]": "card",
      "amount": money,
    };
    return request<dynamic>(
      Method.post,
      url,
      options: Options(headers: getHeader()),
      data: body,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<void> _createCreditCard(
      String customerId, String paymentIntentClientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: customerId,
          paymentIntentClientSecret: paymentIntentClientSecret,
          allowsDelayedPaymentMethods: true,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: "VN",
            testEnv: true,
            currencyCode: "VND",
          )),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}
