import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/presentation_layer/pages/events_screen.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:final_project/core/di/configure_dependencies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventCubit(getIt<EventsUsecase>())..loadedEvents(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Events")),
        body: const EventsFeatureWidget(),
      ),
    );
  }
}
