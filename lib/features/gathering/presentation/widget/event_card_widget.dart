import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class EventCardWidget extends StatelessWidget {
  final String title;
  final String city;
  final String date;
  final String category;
  final String image;

  final bool isBookmarked;
  final VoidCallback onToggleBookmark;
  final VoidCallback onViewDetails;

  const EventCardWidget({
    super.key,
    required this.title,
    required this.city,
    required this.date,
    required this.category,
    required this.image,
    required this.isBookmarked,
    required this.onToggleBookmark,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 23.h),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 195.h,
                  width: 410.w,
                  fit: BoxFit.cover,
                  //shimmer
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: const Color(0xFFD6D6D6),
                    highlightColor: const Color(0xFFF0F0F0),
                    child: Container(
                      height: 195.h,
                      width: 410.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 195,
                    width: double.infinity,
                    color: const Color(0xFFEAEAEA),
                    child: const Icon(
                      CupertinoIcons.exclamationmark_triangle_fill,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
              ),

              // date
              Positioned(
                top: 0.h,
                left: 0.w,
                child: Builder(
                  builder: (context) {
                    final parts = date.split("-");
                    final year = parts[0];
                    final month = parts[1];
                    final day = parts[2];

                    final months = {
                      "01": "gathering.months.jan".tr(),
                      "02": "gathering.months.feb".tr(),
                      "03": "gathering.months.mar".tr(),
                      "04": "gathering.months.apr".tr(),
                      "05": "gathering.months.may".tr(),
                      "06": "gathering.months.jun".tr(),
                      "07": "gathering.months.jul".tr(),
                      "08": "gathering.months.aug".tr(),
                      "09": "gathering.months.sep".tr(),
                      "10": "gathering.months.oct".tr(),
                      "11": "gathering.months.nov".tr(),
                      "12": "gathering.months.dec".tr(),
                    };

                    return Container(
                      width: 56.w,
                      height: 88.h,
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3C3C43).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12.r),
                          topLeft: Radius.circular(12.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: GoogleFonts.cairo(
                              color: CupertinoColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            months[month]!,
                            style: GoogleFonts.cairo(
                              color: CupertinoColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            year,
                            style: GoogleFonts.cairo(
                              color: CupertinoColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // bookmark
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF3C3C43).withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onToggleBookmark,
                    child: Icon(
                      isBookmarked
                          ? CupertinoIcons.bookmark_solid
                          : CupertinoIcons.bookmark,
                      color: isBookmarked
                          ? const Color(0xFFF0F0EE)
                          : const Color(0xFFF0F0EE),
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14).h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title | $category",
                  style: GoogleFonts.cairo(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5B5F4B),
                  ),
                ),

                12.verticalSpace,

                Row(
                  children: [
                    SvgPicture.asset('assets/icons/location_gather.svg'),
                    8.horizontalSpace,
                    Text(
                      city,
                      style: GoogleFonts.cairo(
                        fontSize: 15.sp,
                        color: const Color(0xFF1D1D1D).withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),

                const Gap(18),

                // details button
                SizedBox(
                  width: 140.w,
                  height: 40.h,
                  child: CupertinoButton(
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(12.r),
                    padding: EdgeInsets.zero,
                    onPressed: onViewDetails,
                    child: Text(
                      "gathering.viewDetails".tr(),
                      style: GoogleFonts.cairo(
                        color: Color(0xFFF0F0EE),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
