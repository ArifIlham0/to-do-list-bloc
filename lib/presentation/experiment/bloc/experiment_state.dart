import 'package:todolist_bloc/data/export_data.dart';

abstract class ExperimentState {}

class ExperimentLoading extends ExperimentState {}

class ExperimentLoaded extends ExperimentState {
  ExperimentLoaded({required this.data});

  final DatumExperiment data;
}

class ExperimentFailure extends ExperimentState {
  ExperimentFailure({required this.message});

  final String message;
}