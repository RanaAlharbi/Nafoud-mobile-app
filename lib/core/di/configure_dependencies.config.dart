// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import '../../features/currency_exchange/data_layer/datasource/currency_cache_datasource.dart'
    as _i105;
import '../../features/currency_exchange/data_layer/datasource/currency_exchange_datasource.dart'
    as _i20;
import '../../features/currency_exchange/data_layer/repository/currency_exchange_repository_impl.dart'
    as _i909;
import '../../features/currency_exchange/domain_layer/repository/currency_exchange_repository.dart'
    as _i629;
import '../../features/currency_exchange/domain_layer/usecase/currency_exchange_usecase.dart'
    as _i235;
import '../../features/currency_exchange/presentation_layer/cubit/currency_exchange_cubit.dart'
    as _i1000;
import '../../features/events/data_layer/datasorce/events_datasorce.dart'
    as _i987;
import '../../features/events/data_layer/repository/events_repository.dart'
    as _i442;
import '../../features/events/domain_layer/repository/events_domain_repostiory.dart'
    as _i586;
import '../../features/events/domain_layer/usecase/events_usecase.dart'
    as _i710;
import '../../features/home/presentation_layer/cubit/home_user_info_cubit.dart'
    as _i680;
import '../../features/profile/data_layer/datasource/profile_cache_service.dart'
    as _i158;
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
    gh.lazySingleton<_i361.Dio>(() => thirdPartySetup.dio);
    gh.lazySingleton<_i656.GenerativeModel>(
      () => thirdPartySetup.generativeModel,
    );
    gh.lazySingleton<_i158.ProfileCacheService>(
      () => _i158.ProfileCacheService(),
    );
    gh.lazySingleton<_i987.BaseEventsRemoteDatasource>(
      () => _i987.EventsRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i517.AuthenticationDatasource>(
      () => _i517.SupabaseDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i105.CurrencyCacheDatasource>(
      () => _i105.GetStorageCurrencyCacheDatasource(gh<_i792.GetStorage>()),
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
    gh.lazySingleton<_i18.ProfileDatasource>(
      () => _i18.SupabaseProfileDatasource(
        gh<_i454.SupabaseClient>(),
        gh<_i158.ProfileCacheService>(),
      ),
    );
    gh.lazySingleton<_i998.ProfileRepository>(
      () => _i121.ProfileRepositoryImpl(gh<_i18.ProfileDatasource>()),
    );
    gh.lazySingleton<_i725.AuthenticationRepositoryDomain>(
      () => _i933.DataRepository(gh<_i517.AuthenticationDatasource>()),
    );
    gh.lazySingleton<_i586.EventsDomainRepostiory>(
      () => _i442.EventsRepositoryData(gh<_i987.BaseEventsRemoteDatasource>()),
    );
    gh.lazySingleton<_i20.CurrencyExchangeDatasource>(
      () => _i20.CurrencyExchangeDatasourceImpl(
        gh<_i361.Dio>(),
        gh<_i105.CurrencyCacheDatasource>(),
      ),
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
    gh.lazySingleton<_i710.EventsUsecase>(
      () => _i710.EventsUsecase(gh<_i586.EventsDomainRepostiory>()),
    );
    gh.lazySingleton<_i629.CurrencyExchangeRepository>(
      () => _i909.CurrencyExchangeRepositoryImpl(
        gh<_i20.CurrencyExchangeDatasource>(),
      ),
    );
    gh.singleton<_i680.ProfileUsecase>(
      () => _i680.ProfileUsecase(gh<_i998.ProfileRepository>()),
    );
    gh.factory<_i235.CurrencyExchangeUsecase>(
      () =>
          _i235.CurrencyExchangeUsecase(gh<_i629.CurrencyExchangeRepository>()),
    );
    gh.factory<_i1000.CurrencyExchangeCubit>(
      () => _i1000.CurrencyExchangeCubit(
        gh<_i235.CurrencyExchangeUsecase>(),
        gh<_i105.CurrencyCacheDatasource>(),
      ),
    );
    gh.lazySingleton<_i274.GetChatSessionUseCase>(
      () => _i274.GetChatSessionUseCase(gh<_i351.ChatbotRepositoryDomain>()),
    );
    gh.factory<_i197.ProfileCubit>(
      () => _i197.ProfileCubit(gh<_i680.ProfileUsecase>()),
    );
    gh.factory<_i680.HomeUserInfoCubit>(
      () => _i680.HomeUserInfoCubit(gh<_i680.ProfileUsecase>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i479.ThirdPartySetup {}
