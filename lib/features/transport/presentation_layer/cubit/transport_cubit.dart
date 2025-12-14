import 'package:bloc/bloc.dart';
import 'transport_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportCubit extends Cubit<TransportState> {
  TransportCubit() : super(TransportInitial()) {
    changeTab(0);
  }

  final List<String> tabs = ["Taxi", "Trains", "Public", "Car Rentals"];

  final List<String> tabIcons = [
    "assets/Images/transports/taxi_inactive.svg",
    "assets/Images/transports/train_inactive.svg",
    "assets/Images/transports/Bus_inactive.svg",
    "assets/Images/transports/Car_inactive.svg",
  ];

  final List<String> tabIconsSelected = [
    "assets/Images/transports/taxi_active.svg",
    "assets/Images/transports/train_active.svg",
    "assets/Images/transports/Bus_active.svg",
    "assets/Images/transports/Car_active.svg",
  ];

  final List<Map<String, dynamic>> taxi = [
    {
      "name": "careem",
      // "subtitle": "",
      "image": "assets/Images/transports/careem.svg",
      "url": "https://www.careem.com/",
    },
    {
      "name": "Uber",
      // "subtitle": "",
      "image": "assets/Images/transports/uber.svg",
      "url": "https://www.uber.com/sa/en/",
    },
    {
      "name": "Jeeny",
      // "subtitle": "",
      "image": "assets/Images/transports/jeeny.svg",
      "url": "https://www.jeeny.me/en/",
    },
    {
      "name": "Bolt",
      // "subtitle": "",
      "image": "assets/Images/transports/bolt (1).svg",
      "url": "https://bolt.eu/en-sa/",
    },
  ];

  final List<Map<String, dynamic>> trains = [
    {
      "name": "SAR",
      // "subtitle": "Train to connect northern and central cities",
      "image": "assets/Images/transports/sar.jpg",
      "url": "https://www.sar.com.sa/",
    },
    {
      "name": "HHR",
      // "subtitle": "Train for Makkah, Madinah, Jeddah & KAEC.",
      "image": "assets/Images/transports/HHR.png",
      "url": "https://sar.hhr.sa/ar/home#",
    },
    {
      "name": "Riyadh Metro",
      // "subtitle": "City metro for fast travel within Riyadh",
      "image": "assets/Images/transports/riyadh_metro.png",
      "url": "https://riyadhmetrosa.com/",
    },
  ];

  final List<Map<String, dynamic>> publicTransport = [
    {
      "name": "Riyadh Bus",
      // "subtitle": "",
      "image": "assets/Images/transports/riyadh_metro.png",
      "url": "https://riyadhmetrosa.com/",
    },
    {
      "name": "SAPTCO",
      // "subtitle": "",
      "image": "assets/Images/transports/SAPTCO.jpg",
      "url": "https://saptco.com.sa/en",
    },
  ];

  final List<Map<String, dynamic>> carRentals = [
    {
      "name": "Theeb",
      // "subtitle": "",
      "image": "assets/Images/transports/theeb.png",
      "url": "https://www.theebonline.com/",
    },
    {
      "name": "Key",
      // "subtitle": "",
      "image": "assets/Images/transports/key.jpg",
      "url": "https://www.key.sa/",
    },
    {
      "name": "Budget",
      // "subtitle": "",
      "image": "assets/Images/transports/budget.png",
      "url": "https://www.budget.com/",
    },

    {
      "name": "Hertz",
      // "subtitle": "",
      "image": "assets/Images/transports/hertz.png",
      "url": "https://www.hertz.com/",
    },

    {
      "name": "Lumi",
 
      "image": "assets/Images/transports/lumi.png",
      "url": "https://lumirental.com/",
    },
    {
      "name": "Yelo",
    
      "image": "assets/Images/transports/yelo.jpg",
      "url": "https://www.iyelo.com/en",
    },
    {
      "name": "Sixt",
     
      "image": "assets/Images/transports/sixt.png",
      "url": "https://www.sixt.com.sa/",
    },
  ];

  //tabs changing
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

  // for url navigation
  Future<void> openWebsite(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
