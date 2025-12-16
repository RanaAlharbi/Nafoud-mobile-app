// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
// import 'package:google_fonts/google_fonts.dart';

// import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
// import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
// import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
// import 'dart:async';
// import 'dart:ui' as ui;


// class EventsMapScreen extends StatefulWidget {
//   const EventsMapScreen({super.key});

//   @override
//   State<EventsMapScreen> createState() => _EventsMapScreenState();
// }

// class _EventsMapScreenState extends State<EventsMapScreen> {
//   gmap.GoogleMapController? _mapController;

//   final gmap.LatLng _defaultCenter =
//       const gmap.LatLng(24.7136, 46.6753); // Riyadh

//   double _zoom = 6;
//   Set<gmap.Marker> _markers = {};
//   final Map<String, gmap.BitmapDescriptor> _iconCache = {};

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text(
//           "Events Map",
//           style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
//         ),
//       ),
//       child: SafeArea(
//         child: BlocBuilder<GatheringCubit, GatheringState>(
//           builder: (context, state) {
//             if (state is GatheringLoading) {
//               return const Center(child: CupertinoActivityIndicator());
//             }

//             if (state is GatheringLoaded) {
//               _buildMarkers(state.events);

//               return Stack(
//                 children: [
            
//                   gmap.GoogleMap(
//                     initialCameraPosition: gmap.CameraPosition(
//                       target: _defaultCenter,
//                       zoom: _zoom,
//                     ),
//                     onMapCreated: (c) => _mapController = c,
//                     zoomControlsEnabled: false,
//                     myLocationButtonEnabled: false,
//                     markers: _markers,
//                   ),

//                   Positioned(
//                     bottom: 30,
//                     right: 20,
//                     child: Column(
//                       children: [
//                         _zoomButton(
//                           icon: CupertinoIcons.plus,
//                           onTap: () {
//                             _zoom++;
//                             _mapController?.animateCamera(
//                               gmap.CameraUpdate.zoomTo(_zoom),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 12),
//                         _zoomButton(
//                           icon: CupertinoIcons.minus,
//                           onTap: () {
//                             _zoom--;
//                             _mapController?.animateCamera(
//                               gmap.CameraUpdate.zoomTo(_zoom),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }


//   Future<void> _buildMarkers(List<GatheringEntity> events) async {
//     final markers = <gmap.Marker>{};

//     for (final e in events) {
//       final icon = await _getMarkerIcon(e.category);

//       markers.add(
//         gmap.Marker(
//           markerId: gmap.MarkerId(e.id.toString()),
//           position: gmap.LatLng(e.latitude!, e.longitude!),
//           icon: icon,
//           onTap: () => _showEventDetails(e),
//         ),
//       );
//     }

//     if (mounted) {
//       setState(() => _markers = markers);
//     }
//   }

 
//   Future<gmap.BitmapDescriptor> _getMarkerIcon(String category) async {
//     if (_iconCache.containsKey(category)) {
//       return _iconCache[category]!;
//     }

//     final icon = _categoryIcon(category);
//     final color = _categoryColor(category);

//     final bitmap = await _drawMarker(icon, color);
//     _iconCache[category] = bitmap;
//     return bitmap;
//   }

//   Future<gmap.BitmapDescriptor> _drawMarker(
//     IconData icon,
//     Color color,
//   ) async {
//     const size = 100.0;
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);

//     final paint = Paint()..color = color;
//     canvas.drawCircle(
//       const Offset(size / 2, size / 2),
//       size / 2,
//       paint,
//     );

//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: String.fromCharCode(icon.codePoint),
//         style: TextStyle(
//           fontSize: 48,
//           fontFamily: icon.fontFamily,
//           color: Colors.white,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     );

//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(
//         (size - textPainter.width) / 2,
//         (size - textPainter.height) / 2,
//       ),
//     );

//     final image =
//         await recorder.endRecording().toImage(size.toInt(), size.toInt());
//     final bytes =
//         await image.toByteData(format: ui.ImageByteFormat.png);

//     return gmap.BitmapDescriptor.fromBytes(
//       bytes!.buffer.asUint8List(),
//     );
//   }


//   IconData _categoryIcon(String category) {
//     switch (category) {
//       case "Cultural":
//         return CupertinoIcons.book;
//       case "Sports":
//         return CupertinoIcons.sportscourt;
//       case "Arts":
//         return CupertinoIcons.paintbrush;
//       case "Entertainment":
//         return CupertinoIcons.music_note;
//       default:
//         return CupertinoIcons.location_solid;
//     }
//   }

//   Color _categoryColor(String category) {
//     switch (category) {
//       case "Cultural":
//         return const Color(0xFFC2A480);
//       case "Sports":
//         return const Color(0xFF6C62A5);
//       case "Arts":
//         return const Color(0xFF656A53);
//       case "Entertainment":
//         return const Color(0xFF9C92D1);
//       default:
//         return CupertinoColors.systemGrey;
//     }
//   }

//   void _showEventDetails(GatheringEntity event) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 event.title,
//                 style: GoogleFonts.cairo(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 event.city,
//                 style: GoogleFonts.cairo(color: Colors.grey),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 event.description,
//                 style: GoogleFonts.cairo(fontSize: 15),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: CupertinoButton(
//                   color: const Color(0xFF656A53),
//                   onPressed: () {},
//                   child: const Text("View Details"),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }


//   Widget _zoomButton({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return CupertinoButton(
//       padding: EdgeInsets.zero,
//       onPressed: onTap,
//       child: Container(
//         width: 45,
//         height: 45,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.black),
//       ),
//     );
//   }
// }
