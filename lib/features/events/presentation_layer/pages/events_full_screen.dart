import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/presentation_layer/pages/events_grid_list.dart';
import 'package:final_project/features/home/presentation_layer/cubit/destination_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsFullScreen extends StatelessWidget {
  const EventsFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<EventCubit>()..loadedEvents(),
        ),
        BlocProvider(
          create: (_) => DestinationFilterCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF0F0EE),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: const Color(0xff3D4032)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "All Events",
            style: GoogleFonts.cairo(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff3D4032),
            ),
          ),
          centerTitle: true,
        ),
        body: const EventsGridList(),
      ),
    );
  }
}
