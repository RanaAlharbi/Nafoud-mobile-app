part of 'event_cubit.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class LoadingEvents extends EventState{}

final class LoadedEvents extends EventState{
  final List<EventEntity> events;

const  LoadedEvents(this.events);

  @override
  List<Object> get props => [events];
}

final class EventsError extends EventState{
 final String messsage;

  EventsError(this.messsage);

  @override
  List<Object> get props => [messsage];
}
