import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/navigation/presentation_layer/cubit/navigation_cubit.dart';
import 'package:flutter_svg/svg.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();

    return BlocBuilder<NavigationCubit, NavState>(
      builder: (context, state) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) => cubit.changeIndex(index: value),
            activeColor: Color(0xff656A53),

            inactiveColor: Color(0xFFB5B5B5),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'Assets/icons/nav_home.svg',
                  width: 26,
                  height: 26,
                ),
                label: "Home",
              ),
               BottomNavigationBarItem(
                icon: SvgPicture.asset('Assets/icons/nav_gathering.svg',
                width: 26,
                height: 26,
                ),
                label: "Gather",
              ),
               BottomNavigationBarItem(
               icon: SvgPicture.asset('Assets/icons/nav_ai.svg',
                width: 26,
                height: 26,
                ),
                label: "Murshid",
              ),
               BottomNavigationBarItem(
              icon: SvgPicture.asset('Assets/icons/nav_user.svg',
                width: 26,
                height: 26,
                ),
                label: "Profile",
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return IndexedStack(
              index: cubit.currentIndex,
              children: cubit.screens,
            );
          },
        );
      },
    );
  }
}
