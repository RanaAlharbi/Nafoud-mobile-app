// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart'
    as _i11;
import '../../features/ai_image_analysis/data_layer/repository/ai_image_analysis_repository.dart'
    as _i479;
import '../../features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart'
    as _i855;
import '../../features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart'
    as _i754;
import 'setup.dart' as _i450;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartySetup = _$ThirdPartySetup();
    gh.lazySingleton<_i656.GenerativeModel>(
      () => thirdPartySetup.generativeModel,
    );
    gh.lazySingleton<_i855.AIRepository>(
      () => _i479.AIRepositoryImpl(gh<_i11.AIRemoteDataSource>()),
    );
    gh.lazySingleton<_i754.AnalyzeImageUseCase>(
      () => _i754.AnalyzeImageUseCase(gh<_i855.AIRepository>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i450.ThirdPartySetup {}
