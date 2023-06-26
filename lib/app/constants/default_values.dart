

import 'package:foodapp/app/core.dart';

class DefaultValues {
  
  static List<BankModel> bankList = [
    BankModel(
      id: 0,
      nameBank: "Stripe",
      desBank: "Ngân hàng TMCP Kỹ thương Việt Nam",
      logo: AssetsConst.stripeIc,
    ),
    BankModel(
      id: 1,
      nameBank: "Techcombank (TCB)",
      desBank: "Ngân hàng TMCP Kỹ thương Việt Nam",
      logo: AssetsConst.techcombank,
    ),
    BankModel(
      id: 2,
      nameBank: "Vietinbank (CTG)",
      desBank: "Ngân hàng TMCP Công thương Việt Nam",
      logo: AssetsConst.vietinbank,
    ),
    BankModel(
      id: 3,
      nameBank: "Momo",
      desBank: "Link Momo Wallet",
      logo: AssetsConst.momo,
    ),
  ];
  static const List<Map<String, String>> paymentMethodList = [
    {"title": "Add New Card", "asset": AssetsConst.addRectangle},
  ];

  
}
