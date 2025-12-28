import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class FetchExperimentsUseCase extends UseCase<Either, ExperimentRequest> {
  @override
  Future<Either> call({ExperimentRequest? params}) async {
    return await sl<ExperimentRepository>().fetchExperiments(params ?? ExperimentRequest());
  }
}
