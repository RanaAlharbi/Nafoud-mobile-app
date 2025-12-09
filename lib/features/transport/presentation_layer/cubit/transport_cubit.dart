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
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Uber",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Jeeny",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
        {
      "name": "Bolt",
      "subtitle": "",
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
      "name": "SAR",
      "subtitle": "Train to connect northern and central cities",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "HHR",
      "subtitle": "Train for Makkah, Madinah, Jeddah & KAEC.",
      "image": "assets/images/transports/careem.svg",

      
    },
        {
      "name": "Riyadh Metro",
      "subtitle": "City metro for fast travel within Riyadh",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  final List<Map<String, dynamic>> publicTransport = [
    {
      "name": "Riyadh Bus",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "SAPTCO",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
  ];

  final List<Map<String, dynamic>> carRentals = [
    {
      "name": "Theeb",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Key",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    {
      "name": "Budget",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },

      {
      "name": "Hertz",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
    //Yelo
    {
      "name": "Lumi",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
      {
      "name": "Yelo",
      "subtitle": "",
      "image": "assets/images/transports/careem.svg",
    },
         {
      "name": "Sixt",
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
