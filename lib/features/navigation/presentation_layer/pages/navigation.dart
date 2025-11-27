import 'package:final_project/features/navigation/presentation_layer/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();
    return BlocBuilder<NavigationCubit, NavState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeIndex(index: value);
            },
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "AI", icon: Icon(Icons.camera)),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
