import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_cubit.dart';

class ImageSourcePickerSheet extends StatelessWidget {
  final AIImageCubit cubit;

  const ImageSourcePickerSheet({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () async {
              final picker = ImagePicker();
              final XFile? picked =
                  await picker.pickImage(source: ImageSource.gallery);
              if (picked != null) {
                final bytes = await picked.readAsBytes();
                cubit.pickImage(bytes);
                cubit.analyzeImage();
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () async {
              final picker = ImagePicker();
              final XFile? picked =
                  await picker.pickImage(source: ImageSource.camera);
              if (picked != null) {
                final bytes = await picked.readAsBytes();
                cubit.pickImage(bytes);
                cubit.analyzeImage();
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
