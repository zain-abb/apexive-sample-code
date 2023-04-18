import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../data/models/products/product_model.dart';
import '../../data/models/user/local_user.dart';

abstract class HomeRepository {
  Future<Either<Failure, LocalUser>> getUserFromLocalStorage();
  Future<Either<Failure, ProductList>> getProductsFromServer();
}
