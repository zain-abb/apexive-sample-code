import 'package:apexive/core/request.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/datasource/login_remote_datasource.dart';
import '../features/auth/data/repository/login_user_repository.dart';
import '../features/auth/domain/repository/authentication_user_repository.dart';
import '../features/auth/domain/usecases/authentication_usecase.dart';
import '../features/homepage/data/datasource/homepage_product_remote_source.dart';
import '../features/homepage/data/datasource/homepage_user_local_data_source.dart';
import '../features/homepage/data/repository/homepage_repository.dart';
import '../features/homepage/domain/repository/homepage_repository.dart';
import '../features/homepage/domain/usercases/get_local_user.dart';
import '../features/homepage/domain/usercases/get_products.dart';
import '../features/splash/domain/usecase/check_user_login_status.dart';
import '../services/user_cache_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServiceLocator() async {
  //check if user logged in or not
  serviceLocator.registerFactory<CheckUserLoginStatus>(
    () => CheckUserLoginStatusImpl(),
  );
  // use-case
  serviceLocator.registerFactory<LoginUserUsecase>(() => LoginUserUsecase());

  //datasource
  serviceLocator.registerFactory<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());

  //repositories
  serviceLocator.registerFactory<LoginUserRepository>(() => LoginUserRepositoryImpl());
  //homepage user
  //use-case
  serviceLocator.registerFactory<GetLocalUserUsecase>(() => GetLocalUserUsecase());

  //datasource
  serviceLocator.registerFactory<HomepageLocalUserDataSource>(() => HomepageLocalUserDataSourceImlp());

  //repositories
  serviceLocator.registerFactory<HomepageRepository>(() => HomepageRepositoryImpl());
  //homepage products
  //use-case
  serviceLocator.registerFactory<GetProductsFromServer>(() => GetProductsFromServer());

  //datasource
  serviceLocator.registerFactory<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl());

  //services
  serviceLocator.registerSingleton<UserCacheService>(UserCacheService());
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerFactory<SharedPreferences>(() => sharedPreferences);
  // request
  serviceLocator.registerSingleton<Request>(Request());
}
