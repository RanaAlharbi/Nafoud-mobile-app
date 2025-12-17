import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/shared/Widgets/error_box.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:final_project/features/gathering/presentation/widget/add_button_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/category_chips_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/event_card_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class GatheringScreen extends StatelessWidget {
  const GatheringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GatheringCubit>()..fetchEvents(),

      //provider
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFFF0F0EE),
        navigationBar: CupertinoNavigationBar(
           automaticallyImplyLeading: false,
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
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Row(
                          children: [
                            //search bar
                            const Expanded(child: SearchBarWidget()),
                            13.horizontalSpace,
                          ],
                        ),

                        23.verticalSpace,
                        //categories chips widget
                        CategoryChipsWidget(categories: cubit.categories),

                        23.5.verticalSpace,

                        Expanded(
                          child: () {
                            if (state is GatheringLoading ||
                                state is GatheringLoadingWithCategory) {
                              //loading indictor Cupertino style
                              return Center(
                                child: CupertinoActivityIndicator(
                                  color: Color(0xff3D4032),
                                  radius: 16.r,
                                ),
                              );
                            }

                            if (state is GatheringError) {
                              return ErrorMessageWidget(
                                message: state.message,
                              ); //custom widget for error
                            }

                            if (state is GatheringLoaded) {
                              if (state.events.isEmpty) {
                                //empty category - ui
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/Images/no_events.jpg",
                                        width: 160.w,
                                        height: 160.h,
                                      ),
                                      15.verticalSpace,
                                      Text(
                                        "No events found",
                                        style: GoogleFonts.cairo(
                                          fontSize: 16.sp,
                                          color: const Color(0xFF656A53),
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      cubit.toggleBookmark(e.id!);
                                    },
                                    onViewDetails: () async {
                                      final result = await context.push(
                                        "/eventDetails",
                                        extra: {"event": e, "cubit": cubit},
                                      );

                                      if (result == "refresh") {
                                        cubit.fetchEvents();
                                      }
                                    },
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          }(), //IIFE function
                        ),
                      ],
                    ),
                  ),

                  //Add button
                  Positioned(
                    bottom: 26.h,
                    right: 18.w,
                    child: AddButtonWidget(
                      cubit: cubit,
                    ), //custom widget for add button
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
