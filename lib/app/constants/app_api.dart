// ignore_for_file: lines_longer_than_80_chars
class AppApi {
  static const String apiVer = "";
  //static resources
  //auth
  static const String login = "$apiVer/auth/login";
  static const String register = "$apiVer/auth/register";
  static String getFood(int pageSize, int pageNumber) =>
      "$apiVer/food?pageNumber=$pageNumber&pageSize=$pageSize";
  static String getFoodByCategory(int categoryId) => "$apiVer/food/$categoryId";
  static String getRestaurantById(int id) => "$apiVer/restaurant/$id";
  static String getAllRestaurant = "$apiVer/restaurant";
  static String getCommentByFoodId = "$apiVer/review";
  static String order = "$apiVer/order/insert";
  static String getFavorateFood = "$apiVer/favorite-food";
  static String saveFavorateFood = "$apiVer/favorite-food";
  static String getUserOrder = "$apiVer/order";
  static String deleteFavorateFood(int foodId) =>
      "$apiVer/favorite-food/$foodId";
  static String getRecommendFood = "$apiVer/food/recommend";
  static String getSearchFood = "$apiVer/food/recommend/";
  static String getRecommendFoodId(int userId, int topItem) =>
      "http://192.168.1.153:8000/recommend-food/$userId/$topItem";

  static String getRecommendFoodIdSearch(int userId) =>
      "http://192.168.1.153:8000/recommend-food/$userId";
}
