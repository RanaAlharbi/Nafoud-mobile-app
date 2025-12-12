import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/gathering_cubit.dart';

class CategoryChipsWidget extends StatelessWidget {
  final List<String> categories;

  const CategoryChipsWidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GatheringCubit, GatheringState>(
      builder: (context, state) {
        String selected = "All";

        if (state is GatheringLoaded) selected = state.selectedCategory;
        if (state is GatheringLoadingWithCategory) {
          selected = state.selectedCategory;
        }

        return SizedBox(
          height: 40.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
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
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? CupertinoColors.transparent
                          : const Color(0xFFBEBEBE),
                      width: 1.2.w,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.cairo(
                      color: isSelected
                          ? CupertinoColors.white
                          : const Color(0xFF4A4A41),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
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







// class CategoryChipsWidget extends StatelessWidget {
//   final List<String> categories;
//   final BuildContext providerContext;

//   const CategoryChipsWidget({
//     super.key,
//     required this.categories,
//     required this.providerContext,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GatheringCubit, GatheringState>(
//       builder: (context, state) {
//         return SizedBox(
//           height: 40,
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               return GestureDetector(
//                 onTap: () {
//                   providerContext
//                       .read<GatheringCubit>()
//                       .fetchEvents(category: category);
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF656A53),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     category,
//                     style: GoogleFonts.cairo(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (_, __) => const SizedBox(width: 8),
//             itemCount: categories.length,
//           ),
//         );
//       },
//     );
//   }
// }
