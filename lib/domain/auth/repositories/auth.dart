import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';

abstract class AuthRepository {
  Future<Either> register(AuthenticationRequest request);
  Future<Either> login(AuthenticationRequest request);
}
