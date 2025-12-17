import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';


class MurshidScreen extends StatelessWidget {
  const MurshidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        middle: Text(
          'murshid.murshid'.tr(),
          style: GoogleFonts.cairo(
            color: const Color(0xff3D4032),
            fontSize: 25.9.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF1F1F1).withValues(alpha: 0.8),
        border: null,
      ),

      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/authentication/BackgroundLetters.svg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  61.verticalSpace,

                  Text(
                      'murshid.hi'.tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 25.92.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.cairo(
                        fontSize: 25.92,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      children: [
                        TextSpan(text: 'murshid.intro_prefix'.tr()),
                        TextSpan(
                          text: 'murshid.name'.tr(),
                          style: GoogleFonts.cairo(
                            color: const Color(0xff656A53),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: 'murshid.intro_suffix'.tr()),
                      ],
                    ),
                  ),

                  const Gap(14),

                  Text(
                      'murshid.how_can_help'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff919191),
                    ),
                  ),

                  const Gap(40),

                  GestureDetector(
                    onTap: () {
                      context.push('/chat');
                    },
                    child: Container(
                      width: 388,
                      height: 72,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x1A656A53),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF656A53)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/murshid_trip.svg'),
                          const Gap(10),
                          Text(
                              'murshid.plan_trip'.tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              color: const Color(0xff656A53),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(15),

                  GestureDetector(
                    onTap: () {
                      context.push('/ai-image-analysis-screen');
                    },
                    child: Container(
                      width: 388,
                      height: 72,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x1A656A53),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF656A53)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/murshid_image.svg'),
                          const Gap(10),
                          Text(
                              'murshid.identify_image'.tr(),
                            style: GoogleFonts.cairo(
                              color: const Color(0xff656A53),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
