import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class ExperimentApiService {
  Future<Either> fetchExperiments(ExperimentRequest request);
  Future<Either> fetchCategories();
}

class ExperimentApiServiceImpl extends ExperimentApiService {
  @override
  Future<Either> fetchExperiments(ExperimentRequest request) async {
    try {
      var response = await sl<DioClient>().post(
        "/experiment/fetch",
        options: Options(headers: headersNoToken),
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> fetchCategories() async {
    try {
      var response = await sl<DioClient>().get(
        "/experiment/fetch-category",
        options: Options(headers: headersNoToken),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
