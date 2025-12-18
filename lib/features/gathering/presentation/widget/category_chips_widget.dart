import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/gathering_cubit.dart';

class CategoryChipsWidget extends StatelessWidget {
  final List<String> categories;

  const CategoryChipsWidget({super.key, required this.categories});

  // Method to get translated category name
  String _getTranslatedCategory(String category) {
    final lowerCat = category.toLowerCase();
    switch (lowerCat) {
      case 'all':
        return 'gathering.categories.all'.tr();
      case 'sport':
      case 'sports':
        return 'gathering.categories.sport'.tr();
      case 'music':
        return 'gathering.categories.music'.tr();
      case 'food':
      case 'food & drinks':
        return 'gathering.categories.food'.tr();
      case 'cultural':
      case 'culture':
        return 'gathering.categories.cultural'.tr();
      case 'adventure':
        return 'gathering.categories.adventure'.tr();
      case 'entertainment':
        return 'gathering.categories.entertainment'.tr();
      case 'art':
      case 'arts':
        return 'categories.art'.tr();
      default:
        return category; // Return original if no translation found
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GatheringCubit, GatheringState>(
      builder: (context, state) {
        final selected = state.selectedCategory;
        return SizedBox(
          height: 38.h,

          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, _) => 8.horizontalSpace,
            itemCount: categories.length,
            itemBuilder: (_, i) {
              final cat = categories[i];
              final isSelected = cat == selected;

              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<GatheringCubit>().fetchEvents(category: cat);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 6.h,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF656A53)
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? CupertinoColors.transparent
                          : const Color(0xFFBEBEBE),
                    ),
                  ),
                  child: Text(
                    _getTranslatedCategory(cat),
                    style: GoogleFonts.cairo(
                      color: isSelected
                          ? CupertinoColors.white
                          : const Color(0xFF919191),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
