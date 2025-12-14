import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;

  const ErrorMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle,
            color: Color(0xFF656A53),
            size: 40,
          ),
          12.verticalSpace,
          Text(
            "Something went wrong",
            style: GoogleFonts.cairo(
              fontSize: 18,
              color: Color(0xFF3D4032),
              fontWeight: FontWeight.bold,
            ),
          ),
          6.verticalSpace,
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: Color(0xFF7A7A7A),
            ),
          ),
        ],
      ),
    );
  }
}
