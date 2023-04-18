import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<LoginEvent>(
      (event, emit) async {
        final user = event.user;
        emit(const AuthState.loading());
        var result = await serviceLocator<AuthUsecase>().loginUser(user);
        result.fold(
          (failure) {
            emit(AuthState.error(failure.message));
          },
          (data) {
            emit(AuthState.loaded(user: data));
          },
        );
      },
    );
  }
}
