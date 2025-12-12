import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final cubit = context.read<GatheringCubit>();

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
            onPressed: () async {
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
                title: _titleCtrl.text.trim(),
                description: _descCtrl.text.trim(),
                city: _cityCtrl.text.trim(),
                date: DateFormat("yyyy-MM-dd").format(cubit.selectedDate!),
                eventTime:
                    "${cubit.selectedTime!.hour}:${cubit.selectedTime!.minute.toString().padLeft(2, '0')}",
                address: _addressCtrl.text.trim(),
                imageUrl: cubit.selectedImageUrl!,
                category: cubit.selectedCategory!,
                latitude: cubit.selectedLat,
                longitude: cubit.selectedLng,
              );

              cubit.addEvent(entity);
              Navigator.pop(context);
            },
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

      body: SafeArea(
        child: BlocBuilder<GatheringCubit, GatheringState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePicker(context, cubit),

                  const SizedBox(height: 20),

                  _label("Activity Title"),
                  _input(_titleCtrl, "What’s your activity called?"),

                  _label("About Activity"),
                  _multiInput(_descCtrl, "Describe your activity…"),

                  _label("Activity Category"),
                  _categoryChips(cubit),

                  _label("Activity Dates"),
                  _datePicker(context, cubit),

                  _label("Activity Time"),
                  _timePicker(context, cubit),

                  _label("Pick Location on Map"),
                  InkWell(
                    onTap: () async {
                      final result = await context.push(
                        "/selectLocation",
                        extra: cubit,
                      );

                      if (result != null) {
                        final data = result as Map<String, dynamic>;
                        cubit.setLocation(data["lat"], data["lng"]);
                      }
                    },
                    child: _pickerBox(
                      cubit.selectedLat == null
                          ? "Tap to choose location"
                          : "Lat: ${cubit.selectedLat}, Lng: ${cubit.selectedLng}",
                      Icons.map,
                    ),
                  ),

                  _label("City"),
                  _input(_cityCtrl, "Enter city"),

                  _label("Full Address"),
                  _input(_addressCtrl, "Enter full address"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------- UI -------------------

  Widget _buildImagePicker(BuildContext context, GatheringCubit cubit) {
    return GestureDetector(
      onTap: () async {
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked != null) {
       await cubit.uploadImage(picked.path);
        }
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
      children: cubit.categories
          .where((c) => c != "All")
          .map(
            (cat) => ChoiceChip(
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
            ),
          )
          .toList(),
    );
  }

  Widget _datePicker(BuildContext context, GatheringCubit cubit) {
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );

        if (pickedDate != null) cubit.setDate(pickedDate);
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
    return InkWell(
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) cubit.setTime(pickedTime);
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

  Widget _input(TextEditingController c, String placeholder) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _multiInput(TextEditingController c, String placeholder) {
    return TextField(
      controller: c,
      minLines: 3,
      maxLines: 5,
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



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
// import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uuid/uuid.dart';


// class AddEventScreen extends StatelessWidget {
//   const AddEventScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
   
//     // Controllers
//     final titleController = TextEditingController();
//     final descriptionController = TextEditingController();
//     final cityController = TextEditingController();
//     final addressController = TextEditingController();
//     final imageUrlController = TextEditingController();
//     final dateController = TextEditingController();

//     final categories = ['Cultural', 'Sports', 'Arts','Entertainment'];
//     String selectedCategory = categories[0];

//     //add events of a specific user 
//     final userId = Supabase.instance.client.auth.currentUser?.id;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Event')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Activity Title'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(labelText: 'About Activity '),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: cityController,
//                 decoration: const InputDecoration(labelText: 'Activity Category'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: dateController,
//                 decoration: const InputDecoration(labelText: 'Activity Dates'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: addressController,
//                 decoration: const InputDecoration(labelText: 'Activity Location'),
//               ),
//               TextField(
//                 controller: imageUrlController,
//                 decoration: const InputDecoration(labelText: 'Image URL'),
//               ),
//               const SizedBox(height: 10),
          
//               DropdownButtonFormField<String>(
//                 initialValue: selectedCategory,
//                 items: categories
//                     .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) selectedCategory = value;
//                 },
//                 decoration: const InputDecoration(labelText: 'Category'),
//               ),
//               const SizedBox(height: 20),
             
             
//               ElevatedButton(
//                 onPressed: () {
//                   final event = GatheringModel(
//                     const Uuid().v4(), // ID
//                     userId!,
//                     titleController.text,
//                     descriptionController.text,
//                     cityController.text,
//                     dateController.text,
//                     addressController.text,
//                     imageUrlController.text,
//                     selectedCategory,
//                   );
//                   final cubit = context.read<GatheringCubit>();
//                                   cubit.addEvent(event);

//                   Navigator.pop(context);
//                 },
//                 child: const Text('Add Event'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }