import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/auth/models/request/auth_request.dart';
import 'package:todolist_bloc/domain/auth/repositories/auth.dart';
import 'package:todolist_bloc/service_locator.dart';

class LoginUseCase extends UseCase<Either, AuthRequest> {
  @override
  Future<Either> call({AuthRequest? params}) async {
    return await sl<AuthRepository>().login(params ?? AuthRequest());
  }
}
