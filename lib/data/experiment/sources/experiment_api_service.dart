import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class ExperimentApiService {
  Future<Either> fetchExperiments(ExperimentRequest request);
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
}
