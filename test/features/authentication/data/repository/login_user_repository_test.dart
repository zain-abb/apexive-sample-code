import 'dart:convert';

import 'package:apexive/core/failure.dart';
import 'package:apexive/core/service_locator.dart';
import 'package:apexive/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:apexive/features/auth/data/models/auth_user.dart';
import 'package:apexive/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late AuthRepositoryImpl loginUserRepository;
  setUpAll(() {
    mockRemoteDataSource = MockRemoteDataSource();
    serviceLocator.registerFactory<AuthRemoteDataSource>(() => mockRemoteDataSource);
    loginUserRepository = AuthRepositoryImpl();
  });
  final AuthUser user = AuthUser.fromJson(jsonDecode(fixture('user_response.json')));

  test(
    'should return User object on successful login',
    () async {
      //arrange
      when(() => mockRemoteDataSource.loginUser(user: user)).thenAnswer(
        (_) async => Right(user),
      );
      // act
      final response = await loginUserRepository.login(user: user);
      // assert
      expect(response, Right(user));
    },
  );
  test(
    'should return Failure object on login fail',
    () async {
      //arrange
      when(() => mockRemoteDataSource.loginUser(user: user)).thenAnswer(
        (_) async => const Left(ConnectionFailure('')),
      );
      // act
      final response = await loginUserRepository.login(user: user);
      // assert
      expect(response, const Left(ConnectionFailure('')));
    },
  );
}

class MockRemoteDataSource extends Mock implements AuthRemoteDataSourceImpl {}
