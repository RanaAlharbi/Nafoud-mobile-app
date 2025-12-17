import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/presentation_layer/utils/event_category_utils.dart';

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
            return Center(child: Text("events.noEventsFound".tr()));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                tileColor: Colors.transparent,
                leading: event.category != null
                    ? SvgPicture.asset(
                        EventCategoryUtils.getCategoryImagePath(event.category!),
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.event, size: 50),
                title: Text(event.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("events.date".tr(namedArgs: {'date': event.date})),
                    if (event.location != null)
                      Text("events.locationLabel".tr(namedArgs: {'location': event.location!})),
                    if (event.category != null)
                      Text("events.categoryLabel".tr(namedArgs: {'category': event.category!})),
                  ],
                ),
              );
            },
          );
        }

        if (state is EventsError) {
          return Center(child: Text("events.error".tr(namedArgs: {'message': state.messsage})));
        }

        return const SizedBox.shrink();
      },
    );
  }
}

