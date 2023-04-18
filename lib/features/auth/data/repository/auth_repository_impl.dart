import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/service_locator.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/auth_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, AuthUser>> login({required AuthUser user}) {
    return serviceLocator<AuthRemoteDataSource>().loginUser(
      user: user,
    );
  }
  //
}
