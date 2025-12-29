import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_cubit.dart';
import '../../../common/widgets/export_widgets.dart';

class ExperimentPage extends StatefulWidget {
  const ExperimentPage({super.key});

  @override
  State<ExperimentPage> createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  OverlayEntry? searchOverlay;
  final layerLink = LayerLink();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchInitData();
  }

  Future<void> fetchInitData({bool isRefresh = false}) async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([
      context.read<ExperimentCubit>().fetchExperiments(isRefresh: isRefresh),
      context.read<ExperimentWeightCubit>().fetchExperiments(isRefresh: isRefresh),
      context.read<CategoryCubit>().fetchCategories(isRefresh: isRefresh),
    ]);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void toggleSearchMenu() {
    if (searchOverlay != null) {
      removeSearchMenu();
    } else {
      showSearchMenu();
    }
  }

  void removeSearchMenu() {
    searchOverlay?.remove();
    searchOverlay = null;
  }

  void showSearchMenu() {
    searchOverlay = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: removeSearchMenu,
          child: Stack(
            children: [
              CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: const Offset(-220, 48),
                child: Material(
                  color: Colors.transparent,
                  child: SearchPopup(
                    onClose: removeSearchMenu,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(
      searchOverlay ?? OverlayEntry(builder: (context) {
        return const SizedBox.shrink();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperimentCubit, ExperimentState>(
      builder: (event, state) {
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
                actions: [
                  CompositedTransformTarget(
                    link: layerLink,
                    child: IconButton(
                      icon: const Icon(Icons.search, color: kWhite),
                      onPressed: toggleSearchMenu,
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  fetchInitData(isRefresh: true);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      if (state is ExperimentLoaded && state.data.isNotEmpty)...[
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            itemCount: state.data.length,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 30);
                            },
                            itemBuilder: (context, index) {
                              final data = state.data[index];
                                        
                              return Image.network(
                                width: 200,
                                height: 250,
                                data.image?.url ?? "",
                              );
                            },
                          ),
                        ),
                      ] else if (state is ExperimentLoaded && state.data.isEmpty)...[
                        Center(
                          child: Text("Tidak ada data", style: textStyles(15, kWhite, reguler)),
                        )
                      ],
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weight",
                              style: textStyles(14, kWhite, semiBold),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {},
                              child: Text(
                                "Lihat Semua",
                                style: textStyles(14, kPurple, semiBold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ExperimentWeightCubit, ExperimentWeightState>(
                        builder: (event, state) {
                          if (state is ExperimentWeightLoaded && state.data.isNotEmpty) {
                            return SizedBox(
                              height: 120,
                              child: ListView.separated(
                                itemCount: state.data.length,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 20);
                                },
                                itemBuilder: (context, index) {
                                  final data = state.data[index];
                                            
                                  return Image.network(
                                    width: 100,
                                    height: 100,
                                    data.image?.url ?? "",
                                  );
                                },
                              ),
                            );
                          } else if (state is ExperimentWeightLoaded && state.data.isEmpty) {
                            return Center(
                              child: Text("Tidak ada data", style: textStyles(15, kWhite, reguler)),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const LoadingIndicatorState(),
            ),
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    removeSearchMenu();
    super.dispose();
  }
}