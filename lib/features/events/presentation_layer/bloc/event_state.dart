part of 'event_bloc.dart';

// Base state for Events feature
abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

// Initial state when no action has been taken
final class EventInitial extends EventState {}

// State when events are being loaded
final class LoadingEvents extends EventState {}

// State when events have been successfully loaded
final class LoadedEvents extends EventState {
  final List<EventEntity> events;

  const LoadedEvents(this.events);

  @override
  List<Object> get props => [events];
}

// State when an error occurs while loading events
final class EventsError extends EventState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object> get props => [message];
}
