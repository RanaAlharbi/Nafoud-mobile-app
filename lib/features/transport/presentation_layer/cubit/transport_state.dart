import 'package:equatable/equatable.dart';

abstract class TransportState extends Equatable {
  const TransportState();

  @override
  List<Object?> get props => [];
}

class TransportInitial extends TransportState {}

class TransportTabChanged extends TransportState {
  final int index;
  final List<Map<String, dynamic>> data;

  const TransportTabChanged(this.index, this.data);

  @override
  List<Object?> get props => [index, data];
}
