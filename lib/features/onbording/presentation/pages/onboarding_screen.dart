import 'package:final_project/features/onbording/presentation/cubit/onbording_cubit.dart';
import 'package:final_project/features/onbording/presentation/widget/langauge_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return CupertinoPageScaffold(
          child: Stack(
            children: [
              PageView.builder(
                controller: cubit.pageController,
                onPageChanged: cubit.onPageChanged,
                itemCount: cubit.images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(cubit.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Gradient
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 953.h,
                          width: 440.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF23251D), Color(0x0023251D)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.titles[state],
                        style: GoogleFonts.cairo(
                          color: Color(0xffFBFBFB),
                          fontSize: 25.9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      Gap(8.h),
                      Text(
                        cubit.descriptions[state],
                        style: GoogleFonts.cairo(
                          color: Color(0xffC1C1C1),
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Gap(42.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cubit.images.length,
                          (dotIndex) => Container(
                            margin:  EdgeInsets.symmetric(horizontal: 4.w),
                            width: state == dotIndex ? 10 : 6,
                            height: state == dotIndex ? 10 : 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: state == dotIndex
                                  ? Color(0xff656A53)
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      Gap(26.h),
                      state == cubit.images.length - 1
                          ? Center(
                              child: CupertinoButton(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                minimumSize: Size(360.w, 42.h),
                                onPressed: () {
                                  context.go('/authentication-landing');
                                },

                                child: Text(
                                  "Start Now",
                                  style: GoogleFonts.cairo(
                                    fontSize: 18.sp,
                                    fontWeight: .bold,
                                    color: Color(0xff656A53),
                                  ),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  onPressed: () => cubit.skip(context),
                                  child: Text(
                                    "Skip",
                                    style: GoogleFonts.cairo(
                                      fontSize: 18.sp,
                                      color: const Color(0xffC1C1C1),
                                    ),
                                  ),
                                ),

                                CupertinoButton(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 8.h,
                                  ),
                                  onPressed: cubit.nextPage,

                                  child: Row(
                                    children: [
                                      Text(
                                        "Next",
                                        style: GoogleFonts.cairo(
                                          color: Color(0xFF656A53),
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Gap(10.w),

                                      Icon(
                                        CupertinoIcons.forward,
                                        color: Color(0xFF656A53),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
                      Positioned(
                top: 60.h,
                right: 20.w,
                child: LanguageSwitchButton(
                  languageCode: "EN",
                  onTap: () {
                    // TODO: change language here
                  
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
