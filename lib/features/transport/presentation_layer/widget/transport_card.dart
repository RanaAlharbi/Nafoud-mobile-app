import 'package:final_project/features/transport/presentation_layer/cubit/transport_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;

class TransportCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;
  final String url;

  const TransportCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final ext = p.extension(image).toLowerCase();

 return Container(
  decoration: BoxDecoration(
    color: const Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(22),
  ),
  padding: const EdgeInsets.all(16),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFF656A53), width: 1),
        ),
        child: ClipOval(
          child: ext == ".svg"
              ? SvgPicture.asset(image, fit: BoxFit.cover)
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),

      const SizedBox(height: 10),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          GestureDetector(
            onTap: () =>
                context.read<TransportCubit>().openWebsite(url),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFF7C815E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.arrow_up_right,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),

      if (subtitle.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
        ),
    ],
  ),
);

  }
}
