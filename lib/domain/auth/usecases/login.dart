import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';
import 'package:todolist_bloc/domain/auth/repositories/auth.dart';
import 'package:todolist_bloc/service_locator.dart';

class LoginUseCase extends UseCase<Either, AuthenticationRequest> {
  @override
  Future<Either> call({AuthenticationRequest? params}) async {
    return await sl<AuthRepository>().login(params ?? AuthenticationRequest());
  }
}
