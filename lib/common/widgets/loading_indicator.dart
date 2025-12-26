import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todolist_bloc/core/configs/theme/app_color.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.isButton,
    this.evenOne,
    this.evenTwo,
  });

  final bool? isButton;
  final Color? evenOne;
  final Color? evenTwo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeInOut(
        size: isButton == null ? 40 : 20,
        itemBuilder: (_, int index) {
          return isButton == null
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: index.isEven ? kPurple : kGrey,
                  ),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:
                        index.isEven ? evenOne ?? kWhite : evenTwo ?? kDarkGrey,
                  ),
                );
        },
      ),
    );
  }
}
