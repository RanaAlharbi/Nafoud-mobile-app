import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_cubit.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ErrorPageFeatureScreen extends StatelessWidget {
  const ErrorPageFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorPageCubit, ErrorPageState>(
      listener: (context, state) {
        if (state is ErrorPageSignedOutState) {
          context.go(AppRoutes.signInScreen);
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.error_outline, size: 300.h, color: Colors.red)
                      .animate(
                        onComplete: (controller) async {
                          await Future.delayed(1500.ms);
                          controller.forward(from: 0);
                        },
                      )
                      .shake(duration: 500.ms),
                  Gap(10.h),
                  Text(
                    "How Did We Get Here?",
                    style: TextStyle(fontSize: 30.h),
                  ),
                  Text(
                    "The previous page you were on has a bug that should be reported. You shouldn't be on this page.",
                    style: TextStyle(fontSize: 15.h),
                    textAlign: TextAlign.center,
                  ),
                  Gap(30.h),
                  OutlinedButton(
                    onPressed: () {
                      context.read<ErrorPageCubit>().signOut();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red, width: 2.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      minimumSize: Size(double.infinity, 48.h),
                    ),
                    child: Text(
                      "Go Back To Sign-in Page",
                      style: TextStyle(fontSize: 15.h, fontWeight: .bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
