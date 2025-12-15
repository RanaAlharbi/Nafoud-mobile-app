import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class DestinationFilterCubit extends Cubit<DestinationFilterState> {
  DestinationFilterCubit() : super(const DestinationFilterState('All Destinations'));

  void changeDestination(String destination) {
    emit(DestinationFilterState(destination));
  }
}

class DestinationFilterState extends Equatable {
  final String selectedDestination;

  const DestinationFilterState(this.selectedDestination);

  @override
  List<Object> get props => [selectedDestination];
}
