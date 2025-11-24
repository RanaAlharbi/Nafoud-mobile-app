// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:final_project/core/initial/setup.dart' as _i801;
import 'package:final_project/features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart'
    as _i115;
import 'package:final_project/features/ai_image_analysis/data_layer/repository/ai_image_analysis_repository.dart'
    as _i376;
import 'package:final_project/features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart'
    as _i123;
import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart'
    as _i16;
import 'package:final_project/features/authentication/data_layer/datasource/authentication_datasource.dart'
    as _i1038;
import 'package:final_project/features/authentication/data_layer/repository/authentication_repository.dart'
    as _i60;
import 'package:final_project/features/authentication/domain_layer/repository/authentication_repository.dart'
    as _i410;
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart'
    as _i801;
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart'
    as _i203;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

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
    gh.lazySingleton<_i1038.AuthenticationDatasource>(
      () => _i1038.SupabaseDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i123.AiImageAnalysisRepository>(
      () => _i376.AIRepositoryImpl(gh<_i115.AIRemoteDataSource>()),
    );
    gh.lazySingleton<_i410.AuthenticationRepositoryDomain>(
      () => _i60.DataRepository(gh<_i1038.AuthenticationDatasource>()),
    );
    gh.lazySingleton<_i16.AnalyzeImageUseCase>(
      () => _i16.AnalyzeImageUseCase(gh<_i123.AiImageAnalysisRepository>()),
    );
    gh.lazySingleton<_i801.AuthenticationUsecases>(
      () => _i801.AuthenticationUsecases(
        authRepo: gh<_i410.AuthenticationRepositoryDomain>(),
      ),
    );
    gh.factory<_i203.AuthenticationBloc>(
      () => _i203.AuthenticationBloc(gh<_i801.AuthenticationUsecases>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i801.ThirdPartySetup {}
