import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ErrorPageFeatureScreen extends StatelessWidget {
  const ErrorPageFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _ = context.read<ErrorPageCubit>();

    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.error_outline, size: 100.h),
                Gap(10.h),
                Text("How we got here?", style: TextStyle(fontSize: 40.h)),
                Text(
                  "The pervious page you were on have some bug that should be reported, you shouldn't be in this page",
                  style: TextStyle(fontSize: 20.h),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push(AppRoutes.signInScreen);
                  },
                  child: Text("Go Back To Sign-in Page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
