import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/request.dart';
import '../../../../core/service_locator.dart';
import '../../data/models/user/local_user.dart';
import '../repository/home_repository.dart';

class LocalUserUsecase {
  Future<Either<Failure, LocalUser>> getUserFromLocalStorage() async {
    final response = await serviceLocator<HomeRepository>().getUserFromLocalStorage();
    if (response.isRight()) {
      final responseUser = response.getOrElse(() => LocalUser());
      //persist user authorization in request
      serviceLocator<Request>().updateAuthorization(responseUser.token);
    }

    return response;
  }
}
