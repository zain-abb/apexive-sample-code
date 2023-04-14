import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/request.dart';
import '../../../../core/service_locator.dart';
import '../models/products/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<Either<Failure, ProductList>> getProductFromServer();
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  @override
  Future<Either<Failure, ProductList>> getProductFromServer() async {
    try {
      final Request request = serviceLocator<Request>();
      final response = await request.get('/products');
      if (response.statusCode == 200) {
        ProductList productList = [];
        final productListMap = response.data["products"];
        for (var product in productListMap) {
          productList.add(Product.fromJson(product));
        }
        return Right(productList);
      }
      return Left(
        ConnectionFailure(response.data['message']),
      );
    } catch (e) {
      return const Left(
        ParsingFailure('Unable to parse the response'),
      );
    }
  }
  //
}
