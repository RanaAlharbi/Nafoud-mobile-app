import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';

class EventsFeatureWidget extends StatelessWidget {
  const EventsFeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        if (state is EventInitial || state is LoadingEvents) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LoadedEvents) {
          final events = state.events;
          if (events.isEmpty) {
            return const Center(child: Text("No events found"));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                leading: event.imageUrl != null
                    ? Image.network(
                        event.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : null,
                title: Text(event.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: ${event.date}"),
                    if (event.location != null)
                      Text("Location: ${event.location}"),
                    if (event.category != null)
                      Text("Category: ${event.category}"),
                  ],
                ),
              );
            },
          );
        }

        if (state is EventsError) {
          return Center(child: Text("Error: ${state.messsage}"));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
