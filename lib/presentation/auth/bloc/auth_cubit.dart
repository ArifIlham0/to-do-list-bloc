import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/presentation/auth/bloc/auth_state.dart';
import 'package:todolist_bloc/service_locator.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));

    var checkAuth = await sl<SplashUseCase>().call();

    checkAuth.fold(
      (error) async {
        await UserPreferences().logout();
        emit(Unauthenticated());
      },
      (data) {
        emit(Authenticated());
      },
    );
  }
}
