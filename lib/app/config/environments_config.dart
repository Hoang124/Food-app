import '../core.dart';

///Developnent environment
class DevEnv extends Env {
  DevEnv();

  @override
  // String baseApi = "http://192.168.1.123:8080/api/v1";
  // String baseApi = "http://192.168.5.1:8080/api/v1";
  String baseApi = "https://7d36-2402-800-629c-1866-20a6-7b2b-76e0-8cca.ngrok-free.app/api/v1";

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
  String dbName = "ecovelo-uat";

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
  String dbName = "ecovelo-staging";

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
  String dbName = "ecovelo-prod";

  @override
  String dbVersion = "1.2";
}
