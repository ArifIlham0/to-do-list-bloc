import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/core/configs/assets/app_images.dart';
import 'package:todolist_bloc/presentation/auth/bloc/auth_cubit.dart';
import 'package:todolist_bloc/presentation/auth/bloc/auth_state.dart';
import 'package:todolist_bloc/presentation/experiment/pages/experiment_page.dart';
import 'package:todolist_bloc/presentation/export_pages.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            customNavigation(() => const LoginPage(), isOffAll: true);
          }
          if (state is Authenticated) {
            customNavigation(() => const ExperimentPage(), isOffAll: true);
          }
        },
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(AppImages.splashBackground),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 230.h),
                child: const LoadingIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
