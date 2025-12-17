import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/emergency/domain_layer/usecase/emergency_usecase.dart';
import 'package:final_project/features/emergency/presentation_layer/cubit/emergency_state.dart';
import 'package:final_project/features/emergency/presentation_layer/utils/country_code_to_embassy_mapper.dart';
import 'package:injectable/injectable.dart';

@injectable
class EmergencyCubit extends Cubit<EmergencyState> {
  final EmergencyUseCase useCase;

  EmergencyCubit(this.useCase) : super(const EmergencyInitialState());

  Future<void> loadEmergencyContacts([String? languageCode]) async {
    try {
      emit(const EmergencyLoadingState());

      // Get current language code, default to 'en' if not provided
      final langCode = languageCode ?? 'en';

      final contacts = await useCase.getEmergencyContacts(langCode);
      final embassies = await useCase.getEmbassies(langCode);
      final descriptions = await useCase.getDescriptions(langCode);

      // Load iconMap from JSON
      final String jsonString = await rootBundle.loadString('assets/jsons/emergency_icons.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final Map<String, String> iconMap = Map<String, String>.from(jsonMap);

      // Get user's nationality and map it to embassy name
      final nationality = await useCase.getUserNationality();
      final defaultEmbassy = CountryCodeToEmbassyMapper.getEmbassyName(nationality);

      // Verify that the embassy exists in the embassies map
      final selectedEmbassy = defaultEmbassy != null && embassies.containsKey(defaultEmbassy)
          ? defaultEmbassy
          : null;

      emit(EmergencyLoadedState(
        contacts: contacts,
        filteredContacts: contacts,
        embassies: embassies,
        descriptions: descriptions,
        iconMap: iconMap,
        selectedEmbassy: selectedEmbassy,
      ));
    } catch (e) {
      emit(EmergencyErrorState(e.toString()));
    }
  }

  void filterContacts(String query) {
    if (state is EmergencyLoadedState) {
      final currentState = state as EmergencyLoadedState;

      if (query.isEmpty) {
        emit(currentState.copyWith(filteredContacts: currentState.contacts));
      } else {
        final filtered = currentState.contacts.where((contact) {
          return contact.name.toLowerCase().contains(query.toLowerCase()) ||
              contact.number.toLowerCase().contains(query.toLowerCase());
        }).toList();

        emit(currentState.copyWith(filteredContacts: filtered));
      }
    }
  }

  void selectEmbassy(String? embassy) {
    if (state is EmergencyLoadedState) {
      final currentState = state as EmergencyLoadedState;
      emit(currentState.copyWith(selectedEmbassy: embassy));
    }
  }
}
