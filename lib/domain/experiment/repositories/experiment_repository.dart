import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/export_data.dart';

abstract class ExperimentRepository {
  Future<Either> fetchExperiments(ExperimentRequest request);
}
