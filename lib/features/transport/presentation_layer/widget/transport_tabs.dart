import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransportTabs extends StatelessWidget {
  final int currentIndex;
  final List<String> svgIcons;           
  final List<String> svgIconsSelected;  
  final List<String> labels;
  final Function(int) onTap;


  const TransportTabs({
    super.key,
    required this.currentIndex,
    required this.svgIcons,
    required this.svgIconsSelected,
    required this.labels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: svgIcons.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, i) {
          final selected = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? const Color(0xFF656A53)
                          : const Color(0xFFF7F7F5),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF5E6345)
                            : const Color(0xFF656A53),
                        width: selected ? 2.4 : 1.2,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      selected ? svgIconsSelected[i] : svgIcons[i],
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    labels[i],
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                      color: Color(0xFF121212),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
