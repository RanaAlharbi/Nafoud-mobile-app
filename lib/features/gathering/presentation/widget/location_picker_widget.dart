import 'package:flutter/material.dart';
import 'mini_map_widget.dart';
import 'picker_box.dart';
import '../../presentation/cubit/gathering_cubit.dart';
import 'package:go_router/go_router.dart';

class LocationPickerWidget extends StatelessWidget {
  final GatheringCubit cubit;

  const LocationPickerWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickLocation(context),
      child: cubit.selectedLat == null
          ? const PickerBox(text: "Tap to choose location", icon: 'assets/icons/location.svg',)
          : MiniMapWidget(
              lat: cubit.selectedLat!,
              lng: cubit.selectedLng!,
            ),
    );
  }

  Future<void> _pickLocation(BuildContext context) async {
    final result = await context.push("/select-location", extra: cubit);

    if (result != null) {
      final data = result as Map<String, dynamic>;
      cubit.setLocation(data["lat"], data["lng"]);
    }
  }
}
