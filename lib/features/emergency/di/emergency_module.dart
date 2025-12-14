import 'package:final_project/features/emergency/data_layer/datasource/emergency_datasource.dart';
import 'package:final_project/features/emergency/data_layer/repository/emergency_repository_impl.dart';
import 'package:final_project/features/emergency/domain_layer/repository/emergency_repository.dart';
import 'package:final_project/features/emergency/domain_layer/usecase/emergency_usecase.dart';
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class EmergencyModule {
  @lazySingleton
  EmergencyDataSource get emergencyDataSource => EmergencyDataSourceImpl();

  @lazySingleton
  EmergencyRepository emergencyRepository(EmergencyDataSource dataSource) =>
      EmergencyRepositoryImpl(dataSource);

  @lazySingleton
  EmergencyUseCase emergencyUseCase(
    EmergencyRepository repository,
    ProfileUsecase profileUsecase,
  ) =>
      EmergencyUseCase(repository, profileUsecase);
}
