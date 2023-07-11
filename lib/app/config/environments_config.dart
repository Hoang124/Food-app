import '../core.dart';

///Developnent environment
class DevEnv extends Env {
  DevEnv();

  @override
  // String baseApi = "http://192.168.1.123:8080/api/v1";
  // String baseApi = "http://192.168.5.1:8080/api/v1";
  String baseApi =
      "https://f7ed-2402-800-6294-30c6-711e-398f-23b-7a99.ngrok-free.app/api/v1";

  @override
  EnvType buildType = EnvType.development;

  @override
  String dbName = "food-app-dev";

  @override
  String dbVersion = "1.2";
}

///User Acceptance Testing environment
class UATEnv extends Env {
  UATEnv();

  @override
  String baseApi = "";

  @override
  EnvType buildType = EnvType.uat;

  @override
  String dbName = "food-uat";

  @override
  String dbVersion = "1.2";
}

///Staging environment
class StagingEnv extends Env {
  StagingEnv();

  @override
  String baseApi = "";

  @override
  EnvType buildType = EnvType.staging;

  @override
  String dbName = "food-staging";

  @override
  String dbVersion = "1.2";
}

///Production environment
class ProductionEnv extends Env {
  ProductionEnv();

  @override
  String baseApi = "";

  @override
  EnvType buildType = EnvType.production;

  @override
  String dbName = "food-prod";

  @override
  String dbVersion = "1.2";
}
