import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';
import 'package:todolist_bloc/domain/auth/usecases/register.dart';
import 'package:todolist_bloc/presentation/auth/pages/login.dart';
import 'package:todolist_bloc/service_locator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
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
                  "Register",
                  style: textStyles(30, kWhite, reguler),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Username",
                  style: textStyles(15, kWhite, reguler),
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
                Text(
                  "Password",
                  style: textStyles(15, kWhite, reguler),
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
                SizedBox(height: 20.h),
                Text(
                  "Confirm Password",
                  style: textStyles(15, kWhite, reguler),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  controller: _passwordConfirmController,
                  hintText: "Confirm Password",
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextConfirm,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password is required";
                    } else if (value != _passwordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                    icon: Icon(
                      _obscureTextConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  text: "Register",
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        final result = await sl<RegisterUseCase>().call(
                          params: AuthenticationRequest(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );

                        result.fold(
                          (error) {
                            customSnackbar(error, color: kRed);
                          },
                          (data) {
                            customNavigation(
                              () => const LoginPage(),
                              isOffAll: true,
                              transition: Transition.leftToRight,
                            );
                            customSnackbar(data['message']);
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
                          text: "Already have an account? ",
                          style: textStyles(12, kWhite, reguler),
                        ),
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                          style: textStyles(12, kPurple, bold),
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
