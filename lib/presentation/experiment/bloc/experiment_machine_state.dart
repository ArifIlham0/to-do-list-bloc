import 'package:todolist_bloc/data/export_data.dart';

abstract class ExperimentMachineState {}

class ExperimentMachineLoading extends ExperimentMachineState {}

class ExperimentMachineLoaded extends ExperimentMachineState {
  ExperimentMachineLoaded({required this.data});

  final List<DatumExperiment> data;
}

class ExperimentMachineRefreshing extends ExperimentMachineState {
  ExperimentMachineRefreshing(this.oldData);
  
  final List<DatumExperiment> oldData;
}

class ExperimentMachineFailure extends ExperimentMachineState {
  ExperimentMachineFailure({required this.message});

  final String message;
}