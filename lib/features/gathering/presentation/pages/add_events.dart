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
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class AddEventScreen extends StatelessWidget {
  AddEventScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GatheringCubit>();

    return Scaffold(
      backgroundColor: Color(0xffF0F0EE),
      appBar: AppBar(
        backgroundColor: Color(0xffF0F0EE),
        centerTitle: true,
        title: Text(
          "Create Activity",
          style: GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: .bold,
            color: Color(0xff3D4032),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (cubit.selectedImageUrl == null ||
                  titleController.text.isEmpty ||
                  descController.text.isEmpty ||
                  cubit.selectedDate == null ||
                  cubit.selectedTime == null ||
                  cubit.selectedLat == null ||
                  cubit.selectedLng == null) {
                showError(context, "Please fill all fields");
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
                color: Color(0xff656A53),
              ),

              child: Center(
                child: Text(
                  "Publish",
                  style: GoogleFonts.cairo(
                    color: Color(0xffF0F0EE),
                    fontSize: 12,
                    fontWeight: .bold,
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
              //select image from the device
              ImagePickerWidget(cubit: cubit),
              15.verticalSpace,

              Text(
                "Activity Title",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18.sp,
                  fontWeight: .bold,
                ),
              ),
              4.verticalSpace,
              CustomTextField(
                controller: titleController,
                hint: "What’s your activity called?",
                onChanged: (v) => cubit.updateField("title", v),
              ),
              28.verticalSpace,

              Text(
                "About Activity",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              4.verticalSpace,
              CustomTextField(
                controller: descController,
                hint: "Describe your activity…",
                minLines: 3,
                maxLines: 5,
                onChanged: (v) => cubit.updateField("description", v),
              ),
              20.verticalSpace,

              Text(
                "Activity Category",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              CategoryChipsAdd(cubit: cubit),
              20.verticalSpace,
              Text(
                "Activity Date",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              4.verticalSpace,
              DatePickerWidget(cubit: cubit),
              20.verticalSpace,
              Text(
                "Activity Time",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              4.verticalSpace,
              TimePickerWidget(cubit: cubit),
              20.verticalSpace,
              Text(
                "Pick Location on Map",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              3.verticalSpace,
              LocationPickerWidget(cubit: cubit),
              20.verticalSpace,
              Text(
                "City",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              3.verticalSpace,
              CustomTextField(
                controller: cityController,
                hint: "Enter city",
                onChanged: (v) => cubit.updateField("city", v),
              ),
              20.verticalSpace,
              Text(
                "Full Address",
                style: GoogleFonts.cairo(
                  color: Color(0xff3D4032),
                  fontSize: 18,
                  fontWeight: .bold,
                ),
              ),
              3.verticalSpace,
              CustomTextField(
                controller: addressController,
                hint: "Enter full address",
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
        title: const Text("Error"),
        content: Text(msg),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: GoogleFonts.cairo(color: AppColors.khuzamaColor),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
