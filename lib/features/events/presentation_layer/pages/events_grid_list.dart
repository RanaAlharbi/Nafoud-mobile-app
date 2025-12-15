import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/home/presentation_layer/cubit/destination_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Grid layout events list widget for full events screen (2 columns)
class EventsGridList extends StatelessWidget {
  const EventsGridList({super.key});

  // Method to get category image path
  String _getCategoryImagePath(String? category) {
    if (category == null) return 'assets/Images/events/Empty.svg';

    switch (category.toLowerCase()) {
      case 'shopping':
        return 'assets/Images/events/Shopping.svg';
      case 'sport':
        return 'assets/Images/events/Sport.svg';
      case 'concerts':
        return 'assets/Images/events/Concerts.svg';
      case 'food':
        return 'assets/Images/events/Food.svg';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'assets/Images/events/CulturalAndArts.svg';
      default:
        return 'assets/Images/events/Empty.svg';
    }
  }

  // Method to get category display name
  String _getCategoryDisplayName(String? category) {
    if (category == null) return 'Unknown';

    switch (category.toLowerCase()) {
      case 'shopping':
        return 'Shopping';
      case 'sport':
        return 'Sport';
      case 'concerts':
        return 'Concerts';
      case 'food':
        return 'Food';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'Cultural & Arts';
      default:
        return 'Unknown';
    }
  }

  // Method to get category color
  Color _getCategoryColor(String? category) {
    if (category == null) return Colors.grey;

    switch (category.toLowerCase()) {
      case 'shopping':
        return const Color(0xFF627BA5);
      case 'sport':
        return AppColors.khuzamaColor;
      case 'concerts':
        return Colors.black;
      case 'food':
        return AppColors.primaryColor;
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return AppColors.doohbanColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationFilterCubit, DestinationFilterState>(
      builder: (context, filterState) {
        return BlocBuilder<EventCubit, EventState>(
          builder: (context, eventState) {
            if (eventState is LoadingEvents) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (eventState is LoadedEvents) {
              // Filter events based on selected destination
              var filteredEvents = eventState.events;
              if (filterState.selectedDestination != 'All Destinations') {
                filteredEvents = eventState.events
                    .where(
                      (event) =>
                          event.location?.toLowerCase().contains(
                                filterState.selectedDestination.toLowerCase(),
                              ) ??
                          false,
                    )
                    .toList();
              }

              if (filteredEvents.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 60.sp,
                        color: Colors.grey,
                      ),
                      Gap(16.h),
                      Text(
                        "No events in ${filterState.selectedDestination}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1.0,
                ),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(AppRoutes.eventInfoScreen, extra: event);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Event Image
                          Container(
                            height: 85.h,
                            padding: EdgeInsets.all(12.w),
                            child: Center(
                              child: SvgPicture.asset(
                                _getCategoryImagePath(event.category),
                                width: 60.w,
                                height: 60.h,
                                fit: BoxFit.contain,
                                placeholderBuilder: (context) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Event type
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Text(
                              _getCategoryDisplayName(event.category),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getCategoryColor(event.category),
                              ),
                            ),
                          ),

                          // Event Details
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Gap(6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14.sp,
                                      color: Colors.grey,
                                    ),
                                    Gap(4.w),
                                    Expanded(
                                      child: Text(
                                        event.date,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (eventState is EventsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60.sp,
                      color: Colors.red,
                    ),
                    Gap(16.h),
                    Text(
                      "Error loading events",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
