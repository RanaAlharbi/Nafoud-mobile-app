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
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart'
    as _i11;
import '../../features/ai_image_analysis/data_layer/repository/ai_image_analysis_repository.dart'
    as _i479;
import '../../features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart'
    as _i855;
import '../../features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart'
    as _i754;
import '../../features/authentication/data_layer/datasource/authentication_datasource.dart'
    as _i517;
import '../../features/authentication/data_layer/repository/authentication_repository.dart'
    as _i933;
import '../../features/authentication/domain_layer/repository/authentication_repository.dart'
    as _i725;
import '../../features/authentication/domain_layer/usecase/authentication_usecase.dart'
    as _i11;
import '../../features/authentication/presentation_layer/bloc/authentication_bloc.dart'
    as _i892;
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
    gh.lazySingleton<_i517.AuthenticationDatasource>(
      () => _i517.SupabaseDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i754.AnalyzeImageUseCase>(
      () => _i754.AnalyzeImageUseCase(gh<_i855.AIRepository>()),
    );
    gh.lazySingleton<_i725.AuthenticationRepositoryDomain>(
      () => _i933.DataRepository(gh<_i517.AuthenticationDatasource>()),
    );
    gh.lazySingleton<_i11.AuthenticationUsecases>(
      () => _i11.AuthenticationUsecases(
        authRepo: gh<_i725.AuthenticationRepositoryDomain>(),
      ),
    );
    gh.factory<_i892.AuthenticationBloc>(
      () => _i892.AuthenticationBloc(gh<_i11.AuthenticationUsecases>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i450.ThirdPartySetup {}
