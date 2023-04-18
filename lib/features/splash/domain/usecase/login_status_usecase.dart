import '../../../../core/service_locator.dart';
import '../../../../services/user_cache_service.dart';

class LoginStatusUsecase {
  Future<bool> checkIfUserLoggedIn() async {
    final user = await serviceLocator<UserCacheService>().getUser();
    return user != null;
  }
}
