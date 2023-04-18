import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/failure.dart';
import '../../../../core/request.dart';
import '../../../../core/service_locator.dart';
import '../models/auth_user.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthUser>> loginUser({required AuthUser user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Request request = serviceLocator<Request>();
  @override
  Future<Either<Failure, AuthUser>> loginUser({required AuthUser user}) async {
    try {
      final response = await request.post(
        '/login',
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AuthUser.fromJson(response.data));
      }
      return Left(ConnectionFailure(response.data['message']));
    } catch (e) {
      debugPrint('LoginRemoteDataSourceImplError $e');
      return const Left(
        Exception('Exception Occurred in LoginRemoteDataSourceImpl'),
      );
    }
  }
}
