import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/service_locator.dart';
import '../../../../services/user_cache_service.dart';
import '../models/user/local_user.dart';

abstract class UserLocalDataSource {
  Future<Either<Failure, LocalUser>> getUserFromLocalStorage();
}

class UserLocalDataSourceImlp extends UserLocalDataSource {
  @override
  Future<Either<Failure, LocalUser>> getUserFromLocalStorage() async {
    try {
      final user = serviceLocator<UserCacheService>().user;
      if (user != null) {
        return Right(LocalUser.fromJson(user.toJson()));
      }
      return const Left(
        LocalDatabaseQueryFailure('Unable to query form the shared prefs'),
      );
    } catch (e) {
      return const Left(
        ParsingFailure(
          'Parsing failure occured in HomepageLocalDataSourceImlp',
        ),
      );
    }
  }
}
