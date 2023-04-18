import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';
import '../../data/models/user/local_user.dart';
import '../../domain/usecases/local_user_usecase.dart';
import '../../domain/usecases/products_usecase.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitialState()) {
    on<HomeFetchDataEvent>(
      (event, emit) async {
        emit(const HomeState.loading());
        var userResult = await serviceLocator<LocalUserUsecase>().getUserFromLocalStorage();

        var result = await serviceLocator<ProductsUsecase>().getProductsFromServer();
        result.fold(
          (failure) {
            emit(HomeState.error(failure.message));
          },
          (data) {
            emit(
              HomeState.loadedState(
                productList: data,
                user: userResult.getOrElse(
                  () => LocalUser(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
