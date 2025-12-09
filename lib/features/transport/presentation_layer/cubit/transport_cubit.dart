import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'transport_state.dart';

class TransportCubit extends Cubit<TransportState> {
  TransportCubit() : super(TransportInitial()) {
    changeTab(0);
  }

  final List<String> tabs = ["Taxi", "Trains", "Public", "Car Rentals"];

  final List<Map<String, dynamic>> taxi = [
    {
      "name": "careem",
      "subtitle": "Subtitle 1",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Uber",
      "subtitle": "Subtitle 2",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Jeeny",
      "subtitle": "Subtitle 3",
      "image": "assets/images/transports/careem.svg",
    },
        {
      "name": "Bolt",
      "subtitle": "Subtitle 3",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  final List<IconData> icons = [
    CupertinoIcons.car_detailed,
    CupertinoIcons.train_style_one,
    CupertinoIcons.bus,
    CupertinoIcons.car,
  ];

  final List<Map<String, dynamic>> trains = [
    {
      "name": "Train 1",
      "subtitle": "Subtitle 1",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Train 2",
      "subtitle": "Subtitle 2",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  final List<Map<String, dynamic>> publicTransport = [
    {
      "name": "Bus 1",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Bus 2",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  final List<Map<String, dynamic>> carRentals = [
    {
      "name": "Rental 1",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Rental 2",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Rental 3",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  void changeTab(int index) {
    List<Map<String, dynamic>> data;

    switch (tabs[index]) {
      case "Taxi":
        data = taxi;
        break;
      case "Trains":
        data = trains;
        break;
      case "Public":
        data = publicTransport;
        break;
      case "Car Rentals":
        data = carRentals;
        break;
      default:
        data = [];
    }

    emit(TransportTabChanged(index, data));
  }
}
