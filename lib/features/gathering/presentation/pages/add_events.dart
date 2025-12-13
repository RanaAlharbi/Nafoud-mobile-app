import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddEventScreen extends StatelessWidget {
  AddEventScreen({super.key});

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GatheringCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Create Activity",
          style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => _publish(context, cubit),
            child: const Text(
              "Publish",
              style: TextStyle(
                color: Color(0xFF656A53),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

    
      body: BlocListener<GatheringCubit, GatheringState>(
        listener: (context, state) {
          if (state is GatheringError) {
            _showError(context, state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Activity Image"),
              _buildImagePicker(context, cubit),

              const SizedBox(height: 20),

              _label("Activity Title"),
              _input(
                _titleCtrl,
                "What’s your activity called?",
                cubit.setTitle,
                cubit.title,
              ),

              _label("About Activity"),
              _multiInput(
                _descCtrl,
                "Describe your activity…",
                cubit.setDescription,
                cubit.description,
              ),

              _label("Activity Category"),
              _categoryChips(cubit),

              _label("Activity Dates"),
              _datePicker(context, cubit),

              _label("Activity Time"),
              _timePicker(context, cubit),

       
              _label("Pick Location on Map"),
              cubit.selectedLat == null
                  ? GestureDetector(
                      onTap: () => _pickLocation(context, cubit),
                      child: _pickerBox("Tap to choose location", Icons.map),
                    )
                  : GestureDetector(
                      onTap: () => _pickLocation(context, cubit),
                      child: _miniMap(
                        context,
                        cubit.selectedLat!,
                        cubit.selectedLng!,
                      ),
                    ),

              _label("City"),
              _input(_cityCtrl, "Enter city", cubit.setCity, cubit.city),

              _label("Full Address"),
              _input(
                _addressCtrl,
                "Enter full address",
                cubit.setAddress,
                cubit.address,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _publish(BuildContext context, GatheringCubit cubit) async {
    if (cubit.selectedImageUrl == null ||
        _titleCtrl.text.isEmpty ||
        _descCtrl.text.isEmpty ||
        cubit.selectedCategory == null ||
        cubit.selectedDate == null ||
        cubit.selectedTime == null ||
        cubit.selectedLat == null ||
        cubit.selectedLng == null) {
      _showError(context, "Please fill all fields");
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
      category: cubit.selectedCategory!,
      latitude: cubit.selectedLat,
      longitude: cubit.selectedLng,
    );

    await cubit.addEvent(entity);

    await cubit.fetchEvents();
    context.pop("refresh");
  }


  Future<void> _pickLocation(BuildContext context, GatheringCubit cubit) async {
    final result = await context.push("/select-location", extra: cubit);
    if (result != null) {
      final data = result as Map<String, dynamic>;
      cubit.setLocation(data["lat"], data["lng"]);
    }
  }

  Widget _miniMap(BuildContext context, double lat, double lng) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF656A53)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(lat, lng),
            initialZoom: 15,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: "com.example.final_project",
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, lng),
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildImagePicker(BuildContext context, GatheringCubit cubit) {
    return GestureDetector(
      onTap: () async {
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked != null) await cubit.uploadImage(picked.path);
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF656A53)),
        ),
        child: cubit.selectedImageUrl == null
            ? const Center(child: Text("Upload Image"))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  cubit.selectedImageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }


  Widget _categoryChips(GatheringCubit cubit) {
    return Wrap(
      spacing: 10,
      children: cubit.categories.where((c) => c != "All").map((cat) {
        return ChoiceChip(
          label: Text(cat),
          selected: cubit.selectedCategory == cat,
          selectedColor: const Color(0xFF656A53),
          backgroundColor: Colors.white,
          onSelected: (_) => cubit.setCategory(cat),
          labelStyle: TextStyle(
            color: cubit.selectedCategory == cat
                ? Colors.white
                : const Color(0xFF656A53),
          ),
        );
      }).toList(),
    );
  }

  Widget _datePicker(BuildContext context, GatheringCubit cubit) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (picked != null) cubit.setDate(picked);
      },
      child: _pickerBox(
        cubit.selectedDate == null
            ? "Select activity date"
            : DateFormat("yyyy-MM-dd").format(cubit.selectedDate!),
        Icons.calendar_today,
      ),
    );
  }

  Widget _timePicker(BuildContext context, GatheringCubit cubit) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) cubit.setTime(picked);
      },
      child: _pickerBox(
        cubit.selectedTime == null
            ? "Select activity time"
            : cubit.selectedTime!.format(context),
        Icons.access_time,
      ),
    );
  }

  Widget _pickerBox(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          Icon(icon, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String placeholder,
    Function(String) onChanged,
    String initialValue,
  ) {
    controller.text = initialValue;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _multiInput(
    TextEditingController controller,
    String placeholder,
    Function(String) onChanged,
    String initialValue,
  ) {
    controller.text = initialValue;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      controller: controller,
      minLines: 3,
      maxLines: 5,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showError(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(msg),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
