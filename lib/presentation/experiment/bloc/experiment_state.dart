import 'package:todolist_bloc/data/export_data.dart';

abstract class ExperimentState {}

class ExperimentLoading extends ExperimentState {}

class ExperimentLoaded extends ExperimentState {
  ExperimentLoaded({required this.data});

  final List<DatumExperiment> data;
}

class ExperimentRefreshing extends ExperimentState {
  ExperimentRefreshing(this.oldData);
  
  final List<DatumExperiment> oldData;
}

class ExperimentFailure extends ExperimentState {
  ExperimentFailure({required this.message});

  final String message;
}