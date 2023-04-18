import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../data/models/auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> login({required AuthUser user});
}
