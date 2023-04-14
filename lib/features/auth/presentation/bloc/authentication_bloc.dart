import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';
import '../../domain/usecases/authentication_usecase.dart';
import 'authentication_states.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AutenticationInitialState()) {
    on<LoginUserEvent>(
      (event, emit) async {
        final user = event.user;
        emit(const AuthenticationState.loading());
        var result = await serviceLocator<LoginUserUsecase>().loginUser(user);
        result.fold(
          (failure) {
            emit(AuthenticationState.error(failure.message));
          },
          (data) {
            emit(AuthenticationState.loaded(user: data));
          },
        );
      },
    );
  }
}
