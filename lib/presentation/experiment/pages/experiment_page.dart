import 'package:flutter/material.dart';
import '../../export_cubit.dart';
import '../../../common/widgets/export_widgets.dart';

class ExperimentPage extends StatefulWidget {
  const ExperimentPage({super.key});

  @override
  State<ExperimentPage> createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kBlack,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              'Experiment',
              style: textStyles(18, kWhite, reguler),
            ),
          ),
          body: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
        const LoadingIndicatorCubit<ExperimentCubit, ExperimentState>(),
      ],
    );
  }
}