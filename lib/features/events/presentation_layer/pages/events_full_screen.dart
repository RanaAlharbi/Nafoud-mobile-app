import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/presentation_layer/cubit/category_filter_cubit.dart';
import 'package:final_project/features/home/presentation_layer/cubit/destination_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsFullScreen extends StatelessWidget {
  const EventsFullScreen({super.key});

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

  // Method to get ordered category list (selected category first)
  List<Map<String, String>> _getOrderedCategories(String? selectedCategory) {
    final categories = [
      {'name': 'Sport', 'image': 'assets/Images/event_full/Sport.png'},
      {'name': 'Concerts', 'image': 'assets/Images/event_full/Concerts.png'},
      {'name': 'Shopping', 'image': 'assets/Images/event_full/Shopping.png'},
      {'name': 'Food', 'image': 'assets/Images/event_full/Food.png'},
      {'name': 'Cultural & Arts', 'image': 'assets/Images/event_full/CulturalAndArts.png'},
    ];

    if (selectedCategory != null && selectedCategory != 'All Categories') {
      // Find the selected category and move it to the front
      final selectedIndex = categories.indexWhere(
        (cat) => cat['name'] == selectedCategory,
      );
      if (selectedIndex != -1) {
        final selectedCat = categories.removeAt(selectedIndex);
        categories.insert(0, selectedCat);
      }
    }

    return categories;
  }

  // Method to build clickable category card
  Widget _buildCategoryCard(String category, String imagePath, BuildContext context) {
    return BlocBuilder<CategoryFilterCubit, CategoryFilterState>(
      builder: (context, categoryState) {
        final isSelected = categoryState.selectedCategory == category;

        return GestureDetector(
          onTap: () {
            if (isSelected) {
              // If already selected, clear the filter (show all events)
              context.read<CategoryFilterCubit>().clearFilter();
            } else {
              // Otherwise, select this category
              context.read<CategoryFilterCubit>().changeCategory(category);
            }
          },
          child: SizedBox(
            width: 150.w,
            height: 130.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 40.sp,
                      ),
                    ),
                  ),
                  // Gray overlay when selected
                  if (isSelected)
                    Container(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<EventCubit>()..loadedEvents()),
        BlocProvider(create: (_) => DestinationFilterCubit()),
        BlocProvider(create: (_) => CategoryFilterCubit()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF0F0EE),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: const Color(0xff3D4032)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "All Events",
            style: GoogleFonts.cairo(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff3D4032),
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CategoryFilterCubit, CategoryFilterState>(
          builder: (context, categoryState) {
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
                      // Filter events based on selected destination and category
                      var filteredEvents = eventState.events;

                      // Filter by destination
                      if (filterState.selectedDestination != 'All Destinations') {
                        filteredEvents = filteredEvents
                            .where(
                              (event) =>
                                  event.location?.toLowerCase().contains(
                                    filterState.selectedDestination.toLowerCase(),
                                  ) ??
                                  false,
                            )
                            .toList();
                      }

                      // Filter by category
                      if (categoryState.selectedCategory != 'All Categories') {
                        filteredEvents = filteredEvents
                            .where(
                              (event) =>
                                  event.category?.toLowerCase() ==
                                  categoryState.selectedCategory.toLowerCase(),
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

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 160.h,
                          margin: EdgeInsets.symmetric(vertical: 16.h),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: BlocBuilder<CategoryFilterCubit, CategoryFilterState>(
                              builder: (context, categoryState) {
                                final orderedCategories = _getOrderedCategories(
                                  categoryState.selectedCategory,
                                );

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < orderedCategories.length; i++)
                                      _buildCategoryCard(
                                        orderedCategories[i]['name']!,
                                        orderedCategories[i]['image']!,
                                        context,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Grid section
                      SliverPadding(
                        padding: EdgeInsets.all(16.w),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 1.0,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final event = filteredEvents[index];
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoutes.eventInfoScreen,
                                  extra: event,
                                );
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
                                          width: 40.w,
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
                                          color: _getCategoryColor(
                                            event.category,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Event Details
                                    Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                          }, childCount: filteredEvents.length),
                        ),
                      ),
                    ],
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
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
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
          },
        ),
      ),
    );
  }
}
