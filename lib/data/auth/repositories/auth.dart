import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_bloc/data/auth/models/request/auth_request.dart';
import 'package:todolist_bloc/data/auth/sources/auth_api_service.dart';
import 'package:todolist_bloc/domain/auth/repositories/auth.dart';
import 'package:todolist_bloc/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> register(AuthRequest request) async {
    var data = await sl<AuthApiService>().register(request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> login(AuthRequest request) async {
    var data = await sl<AuthApiService>().login(request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['data']['token']);
        prefs.setInt('id', data['data']['id']);
        prefs.setBool('is_admin', data['data']['is_admin']);
        prefs.setString('username', data['data']['username']);

        return Right(data);
      },
    );
  }

  @override
  Future<Either> checkAuth() async {
    var data = await sl<AuthApiService>().checkAuth();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
