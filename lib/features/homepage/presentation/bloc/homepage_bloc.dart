import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';
import '../../data/models/user/user_model.dart';
import '../../domain/usercases/get_local_user.dart';
import '../../domain/usercases/get_products.dart';
import 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomepageInitialState()) {
    on<HomepageFetchDataEvent>(
      (event, emit) async {
        emit(const HomepageState.loading());
        var userResult = await serviceLocator<GetLocalUserUsecase>().getUserFromLocalStorage();

        var result = await serviceLocator<GetProductsFromServer>().getProductsFromServer();
        result.fold(
          (failure) {
            emit(HomepageState.error(failure.message));
          },
          (data) {
            emit(
              HomepageState.loadedState(
                productList: data,
                user: userResult.getOrElse(
                  () => User(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
