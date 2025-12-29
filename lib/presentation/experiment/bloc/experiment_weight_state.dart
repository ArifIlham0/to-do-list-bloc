import 'package:todolist_bloc/data/export_data.dart';

abstract class ExperimentWeightState {}

class ExperimentWeightLoading extends ExperimentWeightState {}

class ExperimentWeightLoaded extends ExperimentWeightState {
  ExperimentWeightLoaded({required this.data});

  final List<DatumExperiment> data;
}

class ExperimentWeightRefreshing extends ExperimentWeightState {
  ExperimentWeightRefreshing(this.oldData);
  
  final List<DatumExperiment> oldData;
}

class ExperimentWeightFailure extends ExperimentWeightState {
  ExperimentWeightFailure({required this.message});

  final String message;
}