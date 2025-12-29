import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import '../../export_cubit.dart';
import '../../../service_locator.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoading());

  final query = TextEditingController();
  var name = "";
  var category = "";

  Future<void> fetchCategories({bool isRefresh = false}) async {
    if (isRefresh && state is CategoryLoaded) {
      emit(CategoryRefreshing((state as CategoryLoaded).data));
    } else {
      emit(CategoryLoading());
    }

    var data = await sl<FetchCategoriesUseCase>().call();

    data.fold(
      (error) {
        emit(CategoryFailure(message: error));
      },
      (data) {
        emit(CategoryLoaded(data: data));
      },
    );
  }
}
