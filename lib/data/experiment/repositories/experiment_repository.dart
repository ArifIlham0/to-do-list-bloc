import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class ExperimentRepositoryImpl extends ExperimentRepository {

  @override
  Future<Either> fetchExperiments(ExperimentRequest request) async {
    var data = await sl<ExperimentApiService>().fetchExperiments(request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var experimentData = ExperimentsResponse.fromJson(data);
        var experiments = experimentData.data;

        return Right(experiments);
      },
    );
  }

  @override
  Future<Either> fetchCategories() async {
    var data = await sl<ExperimentApiService>().fetchCategories();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var categoryData = CategoriesResponse.fromJson(data);
        var categories = categoryData.data;

        return Right(categories);
      },
    );
  }
}
