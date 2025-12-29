import 'package:todolist_bloc/data/export_data.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({required this.data});

  final List<DatumCategory> data;
}

class CategoryRefreshing extends CategoryState {
  CategoryRefreshing(this.oldData);
  
  final List<DatumCategory> oldData;
}

class CategoryFailure extends CategoryState {
  CategoryFailure({required this.message});

  final String message;
}