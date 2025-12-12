import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:final_project/features/gathering/presentation/widget/category_chips_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/circle_button_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/event_card_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GatheringScreen extends StatelessWidget {
  const GatheringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GatheringCubit>()..fetchEvents(),
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFFF0F0EE),

        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFFF0F0EE),
          middle: Text(
            "Gather",
            style: GoogleFonts.cairo(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: const Color(0xff3D4032),
            ),
          ),
        ),

        child: SafeArea(
          child: BlocBuilder<GatheringCubit, GatheringState>(
            builder: (context, state) {
              final cubit = context.read<GatheringCubit>();
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Gap(20),

                        // SEARCH + BUTTONS
                        Row(
                          children: [
                            const Expanded(child: SearchBarWidget()),
                            const Gap(13),
                            CircleButtonWidget(
                              iconPath: 'assets/icons/murshid_image.svg',
                            ),
                            const Gap(13),
                            CircleButtonWidget(
                              iconPath: 'assets/icons/filter-horizontal.svg',
                            ),
                          ],
                        ),

                        const Gap(16),

                        // CATEGORY CHIPS
                        CategoryChipsWidget(categories: cubit.categories),

                        const Gap(20),

                        Expanded(
                          child: () {
                            if (state is GatheringLoading ||
                                state is GatheringLoadingWithCategory) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }

                            if (state is GatheringError) {
                              return Center(child: Text(state.message));
                            }

                            if (state is GatheringLoaded) {
                              if (state.events.isEmpty) {
                                return const Center(
                                  child: Text("No events found"),
                                );
                              }

                              return ListView.builder(
                                itemCount: state.events.length,
                                itemBuilder: (_, i) {
                                  final e = state.events[i];

                                  return EventCardWidget(
                                    title: e.title,
                                    city: e.city,
                                    date: e.date,
                                    category: e.category,
                                    image: e.imageUrl,
                                    isBookmarked: e.isBookmarked,
                                    onToggleBookmark: () {
                                      context
                                          .read<GatheringCubit>()
                                          .toggleBookmark(e.id!);
                                    },
                                    onViewDetails: () {
                                      context.push("/eventDetails", extra: e);
                                    },
                                  );
                                },
                              );
                            }

                            return const SizedBox();
                          }(),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                        color: Color(0xFF656A53),
                        shape: BoxShape.circle,
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.add,
                          color: CupertinoColors.white,
                          size: 26,
                        ),
                        onPressed: () {
                          context.push(
                            "/addEvent",
                            extra: context.read<GatheringCubit>(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
