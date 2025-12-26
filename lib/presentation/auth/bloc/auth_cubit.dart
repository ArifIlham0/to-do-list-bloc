import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/presentation/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(DisplaySplash());

  void appStarted() async {
    String? token = await StorageHelper().getString("token");

    if (token == null) {
      await StorageHelper().clear();
      emit(Unauthenticated());
    } else {
      emit(Authenticated());
    }
  }
}
