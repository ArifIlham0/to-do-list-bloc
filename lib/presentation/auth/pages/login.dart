import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';
import 'package:todolist_bloc/domain/auth/usecases/login.dart';
import 'package:todolist_bloc/presentation/export_pages.dart';
import 'package:todolist_bloc/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: textStyles(30, kWhite, FontWeight.normal),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Username",
                  style: textStyles(15, kWhite, FontWeight.normal),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  controller: _usernameController,
                  hintText: "Username",
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is required";
                    } else if (value.length < 5) {
                      return "Username must be at least 5 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: textStyles(15, kWhite, FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 8 ||
                        !value.contains(RegExp(r'[0-9]'))) {
                      return "Password must be at least 8 characters and contain numbers";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  text: "Login",
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        final result = await sl<LoginUseCase>().call(
                          params: AuthenticationRequest(
                            emailOrUsername: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );

                        result.fold(
                          (error) {
                            customSnackbar(error, color: kRed);
                          },
                          (success) {
                            customNavigation(() => const MainPage());
                          },
                        );
                      } catch (e) {
                        Get.log(e.toString());
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: textStyles(12, kWhite, FontWeight.normal),
                        ),
                        TextSpan(
                          text: "Register",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              customNavigation(() => const RegisterPage());
                            },
                          style: textStyles(12, kPurple, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }
}
