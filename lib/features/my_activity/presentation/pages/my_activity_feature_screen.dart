import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/shared/Widgets/error_box.dart';
import 'package:final_project/features/gathering/presentation/widget/event_card_widget.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_cubit.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActivityFeatureScreen extends StatelessWidget {
  const MyActivityFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF0F0EE),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFF0F0EE),
        leading: CupertinoNavigationBarBackButton(
          color: const Color(0xff3D4032),
          onPressed: () => context.pop(),
        ),
        middle: Text(
          "myActivity.title".tr(),
          style: GoogleFonts.cairo(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3D4032),
          ),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<MyActivityCubit, MyActivityState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  20.verticalSpace,
                  Expanded(
                    child: () {
                      if (state is MyActivityLoadingState || state is MyActivityInitialState) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: const Color(0xff3D4032),
                            radius: 16.r,
                          ),
                        );
                      }

                      if (state is MyActivityErrorState) {
                        return ErrorMessageWidget(
                          message: state.message,
                        );
                      }

                      if (state is MyActivitySuccessState) {
                        if (state.activity.events.isEmpty) {
                          return CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              CupertinoSliverRefreshControl(
                                onRefresh: () async {
                                  await context
                                      .read<MyActivityCubit>()
                                      .refreshMyActivity();
                                },
                              ),
                              SliverFillRemaining(
                                child: Center(
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
                                        "myActivity.noEventsFound".tr(),
                                        style: GoogleFonts.cairo(
                                          fontSize: 16.sp,
                                          color: const Color(0xFF656A53),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            CupertinoSliverRefreshControl(
                              onRefresh: () async {
                                await context
                                    .read<MyActivityCubit>()
                                    .refreshMyActivity();
                              },
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (_, i) {
                                  final e = state.activity.events[i];
                                  return EventCardWidget(
                                    title: e.title,
                                    city: e.city,
                                    date: e.date,
                                    category: e.category,
                                    image: e.imageUrl,
                                    isBookmarked: e.isBookmarked,
                                    onToggleBookmark: () {
                                      context
                                          .read<MyActivityCubit>()
                                          .toggleBookmark(e.id!);
                                    },
                                    onViewDetails: () async {
                                      await context.push(
                                        "/my-activity-details-screen",
                                        extra: e,
                                      );
                                    },
                                  );
                                },
                                childCount: state.activity.events.length,
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
