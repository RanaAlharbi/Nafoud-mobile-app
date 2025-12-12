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