import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/features/gathering/presentation/widget/category_chips_add.dart';
import 'package:final_project/features/gathering/presentation/widget/custom_text_field.dart';
import 'package:final_project/features/gathering/presentation/widget/date_picker_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/image_picker_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/location_picker_widget.dart';
import 'package:final_project/features/gathering/presentation/widget/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
class AddEventScreen extends StatelessWidget {
  AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GatheringCubit>();

    return Scaffold(
      backgroundColor: const Color(0xffF0F0EE),
      appBar: AppBar(
        backgroundColor: const Color(0xffF0F0EE),
        centerTitle: true,
        title: Text(
          "gathering.createActivity".tr(),
          style: GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3D4032),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (cubit.selectedImageUrl == null ||
                  cubit.title.trim().isEmpty ||
                  cubit.description.trim().isEmpty ||
                  cubit.city.trim().isEmpty ||
                  cubit.address.trim().isEmpty ||
                  cubit.selectedDate == null ||
                  cubit.selectedTime == null ||
                  cubit.selectedLat == null ||
                  cubit.selectedLng == null) {
                showError(context, "gathering.pleaseFillAllFields".tr());
                return;
              }

              final entity = GatheringEntity(
                userId: Supabase.instance.client.auth.currentUser!.id,
                title: cubit.title.trim(),
                description: cubit.description.trim(),
                city: cubit.city.trim(),
                address: cubit.address.trim(),
                date: DateFormat("yyyy-MM-dd").format(cubit.selectedDate!),
                eventTime:
                    "${cubit.selectedTime!.hour}:${cubit.selectedTime!.minute.toString().padLeft(2, '0')}",
                imageUrl: cubit.selectedImageUrl!,
                category: cubit.selectedCategory,
                latitude: cubit.selectedLat,
                longitude: cubit.selectedLng,
              );

              await cubit.addEvent(entity);
              await cubit.fetchEvents();

              context.pop("refresh");
            },
            child: Container(
              width: 58,
              height: 23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xff656A53),
              ),
              child: Center(
                child: Text(
                  "gathering.publish".tr(),
                  style: GoogleFonts.cairo(
                    color: const Color(0xffF0F0EE),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: BlocListener<GatheringCubit, GatheringState>(
        listener: (context, state) {
          if (state is GatheringError) {
            showError(context, state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(cubit: cubit),
              15.verticalSpace,

              Text(
                "gathering.activityTitle".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              CustomTextField(
                initialValue: cubit.title,
                hint: "gathering.activityTitleHint".tr(),
                onChanged: (v) => cubit.updateField("title", v),
              ),
              28.verticalSpace,

              Text(
                "gathering.aboutActivity".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              CustomTextField(
                initialValue: cubit.description,
                hint: "gathering.describeActivity".tr(),
                minLines: 3,
                maxLines: 5,
                onChanged: (v) => cubit.updateField("description", v),
              ),
              20.verticalSpace,

              Text(
                "gathering.activityCategory".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CategoryChipsAdd(cubit: cubit),
              20.verticalSpace,

              Text(
                "gathering.activityDate".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              DatePickerWidget(cubit: cubit),
              20.verticalSpace,

              Text(
                "gathering.activityTime".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              TimePickerWidget(cubit: cubit),
              20.verticalSpace,

              Text(
                "gathering.pickLocationOnMap".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              3.verticalSpace,
              LocationPickerWidget(cubit: cubit),
              20.verticalSpace,

              Text(
                "gathering.city".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              3.verticalSpace,
              CustomTextField(
                initialValue: cubit.city,
                hint: "gathering.enterCity".tr(),
                onChanged: (v) => cubit.updateField("city", v),
              ),
              20.verticalSpace,

              Text(
                "gathering.fullAddress".tr(),
                style: GoogleFonts.cairo(
                  color: const Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              3.verticalSpace,
              CustomTextField(
                initialValue: cubit.address,
                hint: "gathering.enterFullAddress".tr(),
                onChanged: (v) => cubit.updateField("address", v),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showError(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("gathering.error".tr()),
        content: Text(msg),
        actions: [
          TextButton(
            child: Text(
              "gathering.ok".tr(),
              style: GoogleFonts.cairo(color: AppColors.khuzamaColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
