import 'package:apexive/core/request.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/datasource/auth_remote_datasource.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecases/auth_usecase.dart';
import '../features/home/data/datasource/products_remote_source.dart';
import '../features/home/data/datasource/user_local_data_source.dart';
import '../features/home/data/repository/home_repository_impl.dart';
import '../features/home/domain/repository/home_repository.dart';
import '../features/home/domain/usecases/local_user_usecase.dart';
import '../features/home/domain/usecases/products_usecase.dart';
import '../features/splash/domain/usecase/login_status_usecase.dart';
import '../services/user_cache_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServiceLocator() async {
  //check if user logged in or not
  serviceLocator.registerFactory<LoginStatusUsecase>(
    () => LoginStatusUsecase(),
  );
  // use-case
  serviceLocator.registerFactory<AuthUsecase>(() => AuthUsecase());

  //datasource
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());

  //repositories
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  //homepage user
  //use-case
  serviceLocator.registerFactory<LocalUserUsecase>(() => LocalUserUsecase());

  //datasource
  serviceLocator.registerFactory<UserLocalDataSource>(() => UserLocalDataSourceImlp());

  //repositories
  serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl());
  //homepage products
  //use-case
  serviceLocator.registerFactory<ProductsUsecase>(() => ProductsUsecase());

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
