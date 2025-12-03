import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/presentation_layer/pages/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Events")),
      body: BlocProvider(
        create: (context) => getIt<EventCubit>()..loadedEvents(),
        child: const EventsFeatureWidget(),
      ),
    );
  }
}
