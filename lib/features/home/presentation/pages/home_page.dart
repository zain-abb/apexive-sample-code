import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_states.dart';
import '../widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(
          const HomeFetchDataEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      // if (state is HomepageUserLoadedState) {
      //   context.read<HomepageBloc>().add(
      //         const HomepageGetProductEvent(),
      //       );
      // }
    }, builder: (context, state) {
      return Scaffold(
        drawer: state is HomeLoadedState ? HomeDrawer(user: state.user) : null,
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: state is HomeLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is HomeLoadedState
                ? ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      final item = state.productList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.thumbnail),
                        ),
                        title: Text(item.title),
                        subtitle: Text(
                          item.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  )
                : Container(),
      );
    });
  }
}
