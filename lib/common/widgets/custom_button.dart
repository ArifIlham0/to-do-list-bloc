import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.isLoading,
  });

  final String? text;
  final void Function()? onPressed;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: kWhite,
          backgroundColor: kPurple,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 5,
        ),
        child: isLoading == true
            ? const LoadingIndicator(isButton: true)
            : Text(text!, style: textStyles(17, kWhite, FontWeight.normal)),
      ),
    );
  }
}
