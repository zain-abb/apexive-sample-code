import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/service_locator.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/products_remote_source.dart';
import '../datasource/user_local_data_source.dart';
import '../models/products/product_model.dart';
import '../models/user/local_user.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, LocalUser>> getUserFromLocalStorage() {
    return serviceLocator<UserLocalDataSource>().getUserFromLocalStorage();
  }

  @override
  Future<Either<Failure, ProductList>> getProductsFromServer() {
    return serviceLocator<ProductsRemoteDataSource>().getProductFromServer();
  }
}
