part of 'event_bloc.dart';

// Base class for all Event-related events
abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

// Event to load all events
final class LoadEventsEvent extends EventEvent {
  final bool forceRefresh;

  const LoadEventsEvent({this.forceRefresh = false});

  @override
  List<Object> get props => [forceRefresh];
}

// Event to refresh events
final class RefreshEventsEvent extends EventEvent {
  const RefreshEventsEvent();
}
