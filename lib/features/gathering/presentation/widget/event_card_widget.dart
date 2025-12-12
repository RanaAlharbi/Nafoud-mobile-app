import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

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
      margin: const EdgeInsets.only(bottom: 23),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 195,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 195,
                    width: double.infinity,
                    color: const Color(0xFFEAEAEA),
                    child: const Center(child: CupertinoActivityIndicator()),
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
                top: 12,
                left: 12,
                child: Container(
                  width: 55,
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D4032),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      date,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: CupertinoColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // bookmark 
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBEBE9),
                    shape: BoxShape.circle,
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onToggleBookmark,
                    child: Icon(
                      isBookmarked
                          ? CupertinoIcons.bookmark_solid
                          : CupertinoIcons.bookmark,
                      color: const Color(0xFF3D4032),
                      size: 20,
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
                  "$title | $category",
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5B5F4B),
                  ),
                ),

                const Gap(10),

                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      size: 16,
                      color: Color(0xFF6B6F52),
                    ),
                    const Gap(8),
                    Text(
                      city,
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        color: const Color(0xFF1D1D1D).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                const Gap(18),

                // VIEW DETAILS BUTTON (Cupertino)
                SizedBox(
                  width: 150,
                  height: 40,
                  child: CupertinoButton(
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(12),
                    padding: EdgeInsets.zero,
                    onPressed: onViewDetails,
                    child: Text(
                      "View details",
                      style: GoogleFonts.cairo(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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

// class EventCardWidget extends StatelessWidget {
//   final String title;
//   final String city;
//   final String date;
//   final String category;
//   final String image;

//   const EventCardWidget({
//     super.key,
//     required this.title,
//     required this.city,
//     required this.date,
//     required this.category,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 23),
//       decoration: BoxDecoration(
//         color: CupertinoColors.white,
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
//             child: Image.network(
//               image,
//               height: 195,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "$title | $category",
//                   style: GoogleFonts.cairo(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF5B5F4B),
//                   ),
//                 ),

//                 const Gap(12),

//                 Row(
//                   children: [
//                     const Icon(
//                       CupertinoIcons.location,
//                       size: 16,
//                       color: Color(0xFF6B6F52),
//                     ),
//                     const Gap(10),
//                     Text(
//                       city,
//                       style: GoogleFonts.cairo(
//                         fontSize: 15,
//                         color: Color(0xFF1D1D1D).withOpacity(0.5),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
