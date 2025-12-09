import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/widget/circle_button_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/event_card_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class GatheringScreen extends StatelessWidget {
  const GatheringScreen({super.key});

  final List<String> categories = const [
    'All',
    'Cultural',
    'Sports',
    'Arts',
    'Entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GatheringCubit>()..fetchEvents(),
      child: Builder(
        builder: (providerContext) {
          return CupertinoPageScaffold(
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
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Gap(10),
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
                        const Gap(23),
                        BlocBuilder<GatheringCubit, GatheringState>(
                          builder: (context, state) {
                            String selectedCategory = 'All';
                            if (state is GatheringLoaded) {
                              selectedCategory = state.selectedCategory;
                            } else if (state is GatheringLoadingWithCategory) {
                              selectedCategory = state.selectedCategory;
                            }

                            return SizedBox(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                separatorBuilder: (_, _) => const Gap(8),
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  final isSelected =
                                      category == selectedCategory;

                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<GatheringCubit>()
                                          .fetchEvents(category: category);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF656A53)
                                            : Colors.white,
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : const Color(0xFFBEBEBE),
                                          width: 1.2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        category,
                                        style: GoogleFonts.cairo(
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF4A4A41),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const Gap(16),
                        Expanded(
                          child: BlocBuilder<GatheringCubit, GatheringState>(
                            builder: (context, state) {
                              List events = [];
                              bool isLoading = false;

                              if (state is GatheringLoaded) {
                                events = state.events;
                              } else if (state
                                  is GatheringLoadingWithCategory) {
                                isLoading = true;
                              } else if (state is GatheringError) {
                                return Center(child: Text(state.message));
                              }

                              if (isLoading) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              }

                              if (events.isEmpty) {
                                return const Center(
                                  child: Text('No events found'),
                                );
                              }

                              return ListView.builder(                           
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final event = events[index];
                                  return EventCardWidget(
                                    title: event.title,
                                    city: event.city,
                                    date: event.date,
                                    image: event.imageUrl,
                                    category: event.category,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //add button
                Positioned(
                  bottom: 100,
                  right: 8,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF656A53),
                      shape: BoxShape.circle,
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        CupertinoIcons.add,
                        color: CupertinoColors.white,
                        size: 18.5,
                      ),
                      onPressed: () {
                        providerContext.push(AppRoutes.addEventScreen);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
