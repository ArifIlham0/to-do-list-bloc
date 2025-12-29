import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_cubit.dart';
import '../../../service_locator.dart';
import '../../../data/export_data.dart';
import '../../../domain/export_domain.dart';

class ExperimentWeightCubit extends Cubit<ExperimentWeightState> {
  ExperimentWeightCubit() : super(ExperimentWeightLoading());

  final query = TextEditingController();
  var name = "";
  var category = "";

  Future<void> fetchExperiments({bool isRefresh = false}) async {
    if (isRefresh && state is ExperimentWeightLoaded) {
      emit(ExperimentWeightRefreshing((state as ExperimentWeightLoaded).data));
    } else {
      emit(ExperimentWeightLoading());
    }

    var data = await sl<FetchExperimentsUseCase>().call(
      params: ExperimentRequest(
        name: name,
        category: "weights",
      )
    );

    data.fold(
      (error) {
        emit(ExperimentWeightFailure(message: error));
      },
      (data) {
        emit(ExperimentWeightLoaded(data: data));
      },
    );
  }
}
