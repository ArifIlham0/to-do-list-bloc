import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todolist_bloc/common/widgets/export_widgets.dart';

void customNavigation(
  Widget Function() child, {
  bool? isOffAll,
  Transition? transition,
}) {
  if (Platform.isIOS) {
    if (isOffAll == true) {
      Get.offAll(child);
    } else {
      Get.to(child);
    }
  } else {
    if (isOffAll == true) {
      Get.offAll(
        child,
        transition: transition ?? Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    } else {
      Get.to(
        child,
        transition: transition ?? Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    }
  }
}
