import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/service_locator.dart';
import '../../domain/repository/homepage_repository.dart';
import '../datasource/homepage_product_remote_source.dart';
import '../datasource/homepage_user_local_data_source.dart';
import '../models/products/product_model.dart';
import '../models/user/user_model.dart';

class HomepageRepositoryImpl extends HomepageRepository {
  @override
  Future<Either<Failure, User>> getUserFromLocalStorage() {
    return serviceLocator<HomepageLocalUserDataSource>().getUserFromLocalStorage();
  }

  @override
  Future<Either<Failure, ProductList>> getProductsFromServer() {
    return serviceLocator<ProductsRemoteDataSource>().getProductFromServer();
  }
}
