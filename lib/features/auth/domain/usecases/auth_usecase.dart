import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/request.dart';
import '../../../../core/service_locator.dart';
import '../../../../services/user_cache_service.dart';
import '../../data/models/auth_user.dart';
import '../repository/auth_repository.dart';

class AuthUsecase {
  Future<Either<Failure, AuthUser>> loginUser(AuthUser user) async {
    final response = await serviceLocator<AuthRepository>().login(user: user);
    if (response.isRight()) {
      final remoteUser = response.getOrElse(() => AuthUser());
      serviceLocator<Request>().updateAuthorization(
        remoteUser.token,
      );
      await serviceLocator<UserCacheService>().saveUser(remoteUser);
    }
    return response;
  }
}
