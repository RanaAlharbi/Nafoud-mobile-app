import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCardWidget extends StatelessWidget {
  final String title;
  final String city;
  final String date;
  final String category;
  final String image;

  const EventCardWidget({
    super.key,
    required this.title,
    required this.city,
    required this.date,
    required this.category,
    required this.image,
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
          // ================= IMAGE ==================
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
            child: Image.network(
              image,
              height: 195,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // ================= CONTENT ==================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CATEGORY
                Text(
                  "$title | $category",
                  style:  GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: .bold,
                    color: Color(0xFF5B5F4B),
                  ),
                ),
                 Gap(12),

                // city with icons
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Color(0xFF6B6F52)),
                    Gap(10),
                    Text(
                      city,
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        color: Color(0xFF1D1D1D).withValues(alpha: 0.5),
                        fontWeight: .normal,
                      ),
                    ),
                  ],
                ),
                Gap(12),

                //details button
                Container(
                  height: 44,
                  width: 149,
                  decoration: BoxDecoration(
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(8.17),
                  ),
                  child: Center(
                    child: Text(
                      "View details",
                      style: GoogleFonts.cairo(
                        color: Color(0xFFF0F0EE),
                        fontSize: 18,
                        fontWeight: .bold,
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
