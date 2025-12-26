import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class FetchTodosCompleteUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<TodoRepository>().fetchComplete();
  }
}
