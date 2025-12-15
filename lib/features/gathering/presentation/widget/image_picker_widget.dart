import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashed_border/dashed_border.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';

class ImagePickerWidget extends StatelessWidget {
  final GatheringCubit cubit;

  const ImagePickerWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GatheringCubit, dynamic>(
      builder: (context, state) {
        final imgUrl = cubit.selectedImageUrl;

    
        if (imgUrl != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          );
        }

   
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(source: ImageSource.gallery);

            if (picked != null) {
              await cubit.uploadImage(picked.path);
            }
          },
          child: Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              border: DashedBorder(
                color: const Color(0xff656A53),
                width: 2,
                dashLength: 8,
                dashGap: 5,
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Images/Upload_image.png"),
                  const Gap(25),
                  Text(
                    "Upload Your Image Here",
                    style: GoogleFonts.cairo(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
