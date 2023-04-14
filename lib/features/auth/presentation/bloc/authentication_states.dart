import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user_model.dart';

part 'authentication_states.freezed.dart';

@freezed
abstract class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.onLoginTapped({required User user}) = LoginUserEvent;
}

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AutenticationInitialState;
  const factory AuthenticationState.loading() = AutenticationLoadingState;
  const factory AuthenticationState.error(String message) = AutenticationErrorState;
  const factory AuthenticationState.loaded({
    required User user,
  }) = AutenticationLoadedState;
}
