import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkCard extends StatelessWidget {
  final GatheringEntity event;

  const BookmarkCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarkCubit>();

    // Format date
    final parts = event.date.split("-");
    final year = parts[0];
    final month = parts[1];
    final day = parts[2];

    const months = {
      "01": "Jan",
      "02": "Feb",
      "03": "Mar",
      "04": "Apr",
      "05": "May",
      "06": "Jun",
      "07": "Jul",
      "08": "Aug",
      "09": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec",
    };

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 23),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: Image.network(
                  event.imageUrl,
                  height: 195,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Date
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 56,
                  height: 80,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withValues(alpha: 0.6),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                      Text(
                        months[month]!,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                      Text(
                        year,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bookmark icon
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => cubit.toggle(event.id!),
                    child: const Icon(
                      CupertinoIcons.bookmark_solid,
                      color: Color(0xFFF0F0EE),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event.title} | ${event.category}",
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5B5F4B),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    SvgPicture.asset('assets/icons/location_gather.svg'),
                    const SizedBox(width: 8),
                    Text(
                      event.city,
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        color: const Color(0xFF1D1D1D).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: 140,
                  height: 40,
                  child: CupertinoButton(
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(12),
                    padding: EdgeInsets.zero,
                    onPressed: () => context.push(
                      AppRoutes.eventDetails,
                      extra: {
                        "event": event,
                        "cubit": getIt<GatheringCubit>(),
                      },
                    ),
                    child: Text(
                      "View details",
                      style: GoogleFonts.cairo(
                        color: const Color(0xFFF0F0EE),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
