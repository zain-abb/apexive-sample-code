import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/service_locator.dart';
import '../../data/models/products/product_model.dart';
import '../repository/homepage_repository.dart';

class GetProductsFromServer {
  Future<Either<Failure, ProductList>> getProductsFromServer() {
    return serviceLocator<HomepageRepository>().getProductsFromServer();
  }
}
