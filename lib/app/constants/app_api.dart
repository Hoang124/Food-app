// ignore_for_file: lines_longer_than_80_chars
class AppApi {
  static const String apiVer = "";
  //static resources
  //auth
  static const String login = "$apiVer/auth/login";
  static const String register = "$apiVer/auth/register";
  static String getFood(int pageSize, int pageNumber) =>
      "$apiVer/food?pageNumber=$pageNumber&pageSize=$pageSize";
  static String getRestaurantById(int id)=>"$apiVer/restaurant/$id";
}
