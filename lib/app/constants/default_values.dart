import 'package:foodapp/app/core.dart';
import 'package:foodapp/app/pages/cart/models/category_model.dart';

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

  static List<CategoryModel> categoryList = [
    CategoryModel(
      id: 0,
      name: "Recommend",
      image: AssetsConst.mostPopular,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 2,
      name: "Cơm",
      image: AssetsConst.com,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 3,
      name: "Bún",
      image: AssetsConst.bun,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 4,
      name: "Mì",
      image: AssetsConst.mi,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 5,
      name: "Cháo",
      image: AssetsConst.chao,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 6,
      name: "Phở",
      image: AssetsConst.pho,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 7,
      name: "Đồ uống",
      image: AssetsConst.doUong,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 8,
      name: "Chè",
      image: AssetsConst.che,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 9,
      name: "Ăn vặt",
      image: AssetsConst.chao,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 10,
      name: "Fast Food",
      image: AssetsConst.fastFood,
      color: 0xffFFDE8A,
    ),
    CategoryModel(
      id: 1,
      name: "Other",
      image: AssetsConst.allFood,
      color: 0xffFFDE8A,
    )
  ];
}
