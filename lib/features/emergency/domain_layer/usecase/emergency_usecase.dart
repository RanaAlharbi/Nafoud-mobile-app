import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';
import 'package:final_project/features/emergency/domain_layer/repository/emergency_repository.dart';
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart';

class EmergencyUseCase {
  final EmergencyRepository repository;
  final ProfileUsecase profileUsecase;

  EmergencyUseCase(this.repository, this.profileUsecase);

  Future<List<EmergencyContactEntity>> getEmergencyContacts(String languageCode) async {
    return await repository.getEmergencyContacts(languageCode);
  }

  Future<Map<String, String>> getEmbassies(String languageCode) async {
    return await repository.getEmbassies(languageCode);
  }

  Future<Map<String, String>> getDescriptions(String languageCode) async {
    return await repository.getDescriptions(languageCode);
  }

  Future<String?> getUserNationality() async {
    final result = await profileUsecase.getProfile();
    return result.fold(
      (error) => null,
      (profile) => profile.nationality,
    );
  }
}
