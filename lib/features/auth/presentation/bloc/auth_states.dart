import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/auth_user.dart';

part 'auth_states.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.onLoginTapped({required AuthUser user}) = LoginEvent;
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;
  const factory AuthState.loading() = AuthLoadingState;
  const factory AuthState.error(String message) = AuthErrorState;
  const factory AuthState.loaded({
    required AuthUser user,
  }) = AuthLoadedState;
}
