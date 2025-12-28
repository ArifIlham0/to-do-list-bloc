import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_cubit.dart';
import '../../../service_locator.dart';
import '../../../data/export_data.dart';
import '../../../domain/export_domain.dart';

class ExperimentCubit extends Cubit<ExperimentState> {
  ExperimentCubit() : super(ExperimentLoading());

  final query = TextEditingController();
  var name = "";
  var category = "";

  void fetchExperiments() async {
    var data = await sl<FetchExperimentsUseCase>().call(
      params: ExperimentRequest(
        name: name,
        category: category,
      )
    );

    data.fold(
      (error) {
        emit(ExperimentFailure(message: error));
      },
      (data) {
        emit(ExperimentLoaded(data: data));
      },
    );
  }
}
