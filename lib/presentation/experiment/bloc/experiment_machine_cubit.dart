import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_cubit.dart';
import '../../../service_locator.dart';
import '../../../data/export_data.dart';
import '../../../domain/export_domain.dart';

class ExperimentMachineCubit extends Cubit<ExperimentMachineState> {
  ExperimentMachineCubit() : super(ExperimentMachineLoading());

  final query = TextEditingController();
  var name = "";
  var category = "";

  Future<void> fetchMachines({bool isRefresh = false}) async {
    if (isRefresh && state is ExperimentMachineLoaded) {
      emit(ExperimentMachineRefreshing((state as ExperimentMachineLoaded).data));
    } else {
      emit(ExperimentMachineLoading());
    }

    var data = await sl<FetchExperimentsUseCase>().call(
      params: ExperimentRequest(
        name: name,
        category: category,
      )
    );

    data.fold(
      (error) {
        emit(ExperimentMachineFailure(message: error));
      },
      (data) {
        emit(ExperimentMachineLoaded(data: data));
      },
    );
  }
}
