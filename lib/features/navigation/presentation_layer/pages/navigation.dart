import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/navigation/presentation_layer/cubit/navigation_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();

    return BlocBuilder<NavigationCubit, NavState>(
      builder: (context, state) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              tabLabelTextStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeIndex(index: value),
              activeColor: Color(0xff656A53),
              inactiveColor: Color(0xFFB5B5B5),
              backgroundColor: Color(0x00000000),
              height: 70.h,
              items: [
                BottomNavigationBarItem(

                  icon: SvgPicture.asset(
                    'assets/icons/nav_home.svg',
                    width: 32.h,
                    height: 32.h,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/nav_home.svg',
                    width: 32.h,
                    height: 32.h,
                    colorFilter: ColorFilter.mode(
                      Color(0xff656A53),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "nav.home".tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/nav_gathering-cropped.svg',
                    width: 34.h,
                    height: 34.h,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/nav_gathering-cropped.svg',
                    width: 34.h,
                    height: 34.h,
                    colorFilter: ColorFilter.mode(
                      Color(0xff656A53),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "nav.gather".tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/nav_ai.svg',
                    width: 32.h,
                    height: 32.h,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/nav_ai.svg',
                    width: 32.h,
                    height: 32.h,
                    colorFilter: ColorFilter.mode(
                      Color(0xff656A53),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "nav.murshid".tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/nav_user.svg',
                    width: 32.h,
                    height: 32.h,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/nav_user.svg',
                    width: 32.h,
                    height: 32.h,
                    colorFilter: ColorFilter.mode(
                      Color(0xff656A53),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "nav.profile".tr(),
                ),
              ],
            ),
            tabBuilder: (context, index) {
              return IndexedStack(
                index: cubit.currentIndex,
                children: cubit.screens.map((screen) {
                  return KeyedSubtree(
                    key: ValueKey('${screen.runtimeType}_${context.locale.languageCode}'),
                    child: screen,
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
