import 'package:get_it/get_it.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/domain/export_domain.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<TodoApiService>(TodoApiServiceImpl());
  sl.registerSingleton<ExperimentApiService>(ExperimentApiServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl());
  sl.registerSingleton<ExperimentRepository>(ExperimentRepositoryImpl());

  // sl.registerSingleton<SplashUseCase>(SplashUseCase());
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase());
  sl.registerSingleton<FetchTodosUseCase>(FetchTodosUseCase());
  sl.registerSingleton<CreateTodoUseCase>(CreateTodoUseCase());
  sl.registerSingleton<UpdateTodoUseCase>(UpdateTodoUseCase());
  sl.registerSingleton<DeleteTodoUseCase>(DeleteTodoUseCase());
  sl.registerSingleton<FetchTodosOverdueUseCase>(FetchTodosOverdueUseCase());
  sl.registerSingleton<FetchTodosCompleteUseCase>(FetchTodosCompleteUseCase());
  sl.registerSingleton<FetchExperimentsUseCase>(FetchExperimentsUseCase());
  sl.registerSingleton<FetchCategoriesUseCase>(FetchCategoriesUseCase());
}
