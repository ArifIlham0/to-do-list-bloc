import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/auth/models/request/auth_request.dart';

abstract class AuthRepository {
  Future<Either> register(AuthRequest request);
  Future<Either> login(AuthRequest request);
  Future<Either> checkAuth();
}
