
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
    required this.cubit,
  });

  final GatheringCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.w,
      height: 58.w,
      decoration: const BoxDecoration(
        color: Color(0xFF656A53),
        shape: BoxShape.circle,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
          CupertinoIcons.add,
          color: CupertinoColors.white,
          size: 26.sp,
        ),
        onPressed: () async {
          final result = await context.push(
            "/addEvent",
            extra: cubit,
          );
    
          if (result == "refresh") {
            cubit.fetchEvents();
          }
        },
      ),
    );
  }
}
