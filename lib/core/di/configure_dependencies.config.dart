// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/AI_Chatbot/data_layer/datasource/chatbot_datasource.dart'
    as _i504;
import '../../features/AI_Chatbot/data_layer/repository/chatbot_repository_data.dart'
    as _i181;
import '../../features/AI_Chatbot/domain_layer/repository/chatbot_repository_domain.dart'
    as _i351;
import '../../features/AI_Chatbot/domain_layer/usecase/chatbot_usecase.dart'
    as _i274;
import '../../features/AI_Chatbot/presentation_layer/bloc/chatbot_bloc.dart'
    as _i824;
import '../../features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart'
    as _i11;
import '../../features/ai_image_analysis/data_layer/datasource/ai_local_storage_datasource.dart'
    as _i157;
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
import '../../features/profile/data_layer/datasource/profile_datasource.dart'
    as _i18;
import '../../features/profile/data_layer/repository/profile_repository_impl.dart'
    as _i121;
import '../../features/profile/domain_layer/repository/profile_repository.dart'
    as _i998;
import '../../features/profile/domain_layer/usecase/profile_usecase.dart'
    as _i680;
import '../../features/profile/presentation_layer/cubit/profile_cubit.dart'
    as _i197;
import 'third_party_config.dart' as _i479;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartySetup = _$ThirdPartySetup();
    gh.lazySingleton<_i792.GetStorage>(() => thirdPartySetup.storage);
    gh.lazySingleton<_i454.SupabaseClient>(
      () => thirdPartySetup.supabaseClient,
    );
    gh.lazySingleton<_i656.GenerativeModel>(
      () => thirdPartySetup.generativeModel,
    );
    gh.lazySingleton<_i517.AuthenticationDatasource>(
      () => _i517.SupabaseDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i18.ProfileDatasource>(
      () => _i18.SupabaseProfileDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i157.BaseAiLocalStorageDataSource>(
      () => _i157.AiLocalStorageDataSource(gh<_i792.GetStorage>()),
    );
    gh.lazySingleton<_i11.BaseAiImageAnalysisDataSource>(
      () => _i11.AiImageAnalysisRemoteDataSource(gh<_i656.GenerativeModel>()),
    );
    gh.lazySingleton<_i855.AiImageAnalysisRepository>(
      () => _i479.AiImageAnalysisRepositoryDataSource(
        gh<_i11.BaseAiImageAnalysisDataSource>(),
        gh<_i157.BaseAiLocalStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i504.ChatDataSource>(() => _i504.ChatRemoteDataSource());
    gh.lazySingleton<_i998.ProfileRepository>(
      () => _i121.ProfileRepositoryImpl(gh<_i18.ProfileDatasource>()),
    );
    gh.lazySingleton<_i725.AuthenticationRepositoryDomain>(
      () => _i933.DataRepository(gh<_i517.AuthenticationDatasource>()),
    );
    gh.lazySingleton<_i754.AnalyzeImageUseCase>(
      () => _i754.AnalyzeImageUseCase(gh<_i855.AiImageAnalysisRepository>()),
    );
    gh.lazySingleton<_i11.AuthenticationUsecases>(
      () => _i11.AuthenticationUsecases(
        authRepo: gh<_i725.AuthenticationRepositoryDomain>(),
      ),
    );
    gh.lazySingleton<_i351.ChatbotRepositoryDomain>(
      () => _i181.ChatbotRepositoryData(gh<_i504.ChatDataSource>()),
    );
    gh.factory<_i892.AuthenticationBloc>(
      () => _i892.AuthenticationBloc(gh<_i11.AuthenticationUsecases>()),
    );
    gh.factory<_i680.ProfileUsecase>(
      () => _i680.ProfileUsecase(gh<_i998.ProfileRepository>()),
    );
    gh.lazySingleton<_i274.GetChatSessionUseCase>(
      () => _i274.GetChatSessionUseCase(gh<_i351.ChatbotRepositoryDomain>()),
    );
    gh.factory<_i197.ProfileCubit>(
      () => _i197.ProfileCubit(gh<_i680.ProfileUsecase>()),
    );
    gh.factory<_i824.ChatbotBloc>(
      () => _i824.ChatbotBloc(gh<_i274.GetChatSessionUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i479.ThirdPartySetup {}
