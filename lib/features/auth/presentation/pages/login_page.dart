import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/auth_user.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_states.dart';
import '../shared/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login-screen';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthField(
            hintText: 'Username',
            controller: _emailController,
            key: const Key('username-field'),
          ),
          AuthField(
            hintText: 'Password',
            controller: _passwordController,
            obscureText: true,
            key: const Key('password-field'),
          ),
          const SizedBox(height: 16.0),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                  ),
                );
              } else if (state is AuthLoadedState) {
                AutoRouter.of(context).pushNamed('/home-page');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'User logged in successfully',
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: 54.0,
                width: 180.0,
                child: ElevatedButton(
                  key: const Key('login-button'),
                  style: const ButtonStyle(),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthEvent.onLoginTapped(
                            user: AuthUser(
                              username: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                  },
                  child: const Text(
                    'Login',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
