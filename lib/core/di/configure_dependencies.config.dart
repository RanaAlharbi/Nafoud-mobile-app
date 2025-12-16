// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as _i336;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:get_storage/src/storage_impl.dart' as _i488;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

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
import '../../features/ai_trip_planner/data_layer/data_source/ai_trip_datasource.dart'
    as _i39;
import '../../features/ai_trip_planner/data_layer/repository/ai_trip_data_repository.dart'
    as _i557;
import '../../features/ai_trip_planner/domain_layer/repository/ai_trip_domain_repository.dart'
    as _i106;
import '../../features/ai_trip_planner/domain_layer/usecase/ai_trip_usecase.dart'
    as _i1040;
import '../../features/authentication/data_layer/datasource/authentication_datasource.dart'
    as _i517;
import '../../features/authentication/data_layer/repository/authentication_repository.dart'
    as _i933;
import '../../features/authentication/domain_layer/repository/authentication_repository.dart'
    as _i725;
import '../../features/authentication/domain_layer/usecase/authentication_usecase.dart'
    as _i11;
import '../../features/bookmarks/data/datasource/bookmarks_datasorce.dart'
    as _i631;
import '../../features/bookmarks/data/repo/data_repo.dart' as _i1023;
import '../../features/bookmarks/domain/repo/bookmarks_repo.dart' as _i936;
import '../../features/bookmarks/domain/usecase/add_bookmark_usecase.dart'
    as _i605;
import '../../features/bookmarks/domain/usecase/get_bookmarks_usecase.dart'
    as _i50;
import '../../features/bookmarks/domain/usecase/get_event_by_id.dart' as _i661;
import '../../features/bookmarks/domain/usecase/remove_bookmark_usecase.dart'
    as _i664;
import '../../features/bookmarks/presentation/cubit/bookmarks_cubit.dart'
    as _i197;
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
import '../../features/emergency/data_layer/datasource/emergency_datasource.dart'
    as _i300;
import '../../features/emergency/di/emergency_module.dart' as _i313;
import '../../features/emergency/domain_layer/repository/emergency_repository.dart'
    as _i569;
import '../../features/emergency/domain_layer/usecase/emergency_usecase.dart'
    as _i449;
import '../../features/emergency/presentation_layer/cubit/emergency_cubit.dart'
    as _i697;
import '../../features/error_page/data/datasources/error_page_local_data_source.dart'
    as _i1022;
import '../../features/error_page/data/datasources/error_page_remote_data_source.dart'
    as _i781;
import '../../features/error_page/data/repositories/error_page_repository_data.dart'
    as _i639;
import '../../features/error_page/domain/repositories/error_page_repository_domain.dart'
    as _i626;
import '../../features/error_page/domain/use_cases/error_page_use_case.dart'
    as _i752;
import '../../features/error_page/presentation/cubit/error_page_cubit.dart'
    as _i1002;
import '../../features/events/data_layer/datasorce/events_datasorce.dart'
    as _i987;
import '../../features/events/data_layer/repository/events_repository.dart'
    as _i442;
import '../../features/events/domain_layer/repository/events_domain_repostiory.dart'
    as _i586;
import '../../features/events/domain_layer/usecase/events_usecase.dart'
    as _i710;
import '../../features/events/presentation_layer/bloc/event_bloc.dart' as _i5;
import '../../features/events/presentation_layer/cubit/event_cubit.dart'
    as _i985;
import '../../features/gathering/data_layer/datasource/gathering_remote_datasource.dart'
    as _i971;
import '../../features/gathering/data_layer/repo/gathering_repo_datasorce.dart'
    as _i445;
import '../../features/gathering/domain_layer/repo/gathering_domain_repository.dart'
    as _i1007;
import '../../features/gathering/domain_layer/usecase/add_bookmark_usecase.dart'
    as _i462;
import '../../features/gathering/domain_layer/usecase/create_gathering_usecase.dart'
    as _i753;
import '../../features/gathering/domain_layer/usecase/delete_gathering_usecase.dart'
    as _i390;
import '../../features/gathering/domain_layer/usecase/get_gatherings_usecase.dart'
    as _i547;
import '../../features/gathering/domain_layer/usecase/get_map_events_usecase.dart'
    as _i1066;
import '../../features/gathering/domain_layer/usecase/get_participants_usecase.dart'
    as _i978;
import '../../features/gathering/domain_layer/usecase/get_user_bookmark.dart'
    as _i283;
import '../../features/gathering/domain_layer/usecase/join_event_usecase.dart'
    as _i310;
import '../../features/gathering/domain_layer/usecase/remove_bookmark_usecase.dart'
    as _i601;
import '../../features/gathering/domain_layer/usecase/search_event_usecase.dart'
    as _i1059;
import '../../features/gathering/domain_layer/usecase/upload_image_usecase.dart'
    as _i827;
import '../../features/gathering/presentation/cubit/gathering_cubit.dart'
    as _i142;
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
import '../../features/weather/data/datasources/weather_get_storage_data_source.dart'
    as _i362;
import '../../features/weather/data/datasources/weather_local_data_source.dart'
    as _i609;
import '../../features/weather/data/datasources/weather_remote_data_source.dart'
    as _i97;
import '../../features/weather/data/repositories/weather_repository_data.dart'
    as _i122;
import '../../features/weather/domain/repositories/weather_repository_domain.dart'
    as _i46;
import '../../features/weather/domain/use_cases/weather_use_case.dart' as _i324;
import '../../features/weather/presentation/cubit/weather_cubit.dart' as _i695;
import 'third_party_config.dart' as _i479;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartySetup = _$ThirdPartySetup();
    final emergencyModule = _$EmergencyModule();
    gh.lazySingleton<_i792.GetStorage>(() => thirdPartySetup.storage);
    gh.lazySingleton<_i454.SupabaseClient>(
      () => thirdPartySetup.supabaseClient,
    );
    gh.lazySingleton<_i361.Dio>(() => thirdPartySetup.dio);
    gh.lazySingleton<_i336.FlutterGooglePlacesSdk>(
      () => thirdPartySetup.googlePlaces,
    );
    gh.lazySingleton<_i656.GenerativeModel>(
      () => thirdPartySetup.generativeModel,
    );
    gh.lazySingleton<_i300.EmergencyDataSource>(
      () => emergencyModule.emergencyDataSource,
    );
    gh.lazySingleton<_i158.ProfileCacheService>(
      () => _i158.ProfileCacheService(),
    );
    gh.lazySingleton<_i39.TripDataSource>(() => _i39.TripRemoteDataSource());
    gh.lazySingleton<_i987.BaseEventsRemoteDatasource>(
      () => _i987.EventsRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1022.BaseErrorPageLocalDataSource>(
      () => _i1022.ErrorPageLocalDataSource(),
    );
    gh.lazySingleton<_i971.BaseGatheringRemoteDataSource>(
      () => _i971.GatheringRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i105.CurrencyCacheDatasource>(
      () => _i105.GetStorageCurrencyCacheDatasource(gh<_i792.GetStorage>()),
    );
    gh.lazySingleton<_i781.BaseErrorPageRemoteDataSource>(
      () => _i781.ErrorPageRemoteDataSource(),
    );
    gh.lazySingleton<_i157.BaseAiLocalStorageDataSource>(
      () => _i157.AiLocalStorageDataSource(gh<_i792.GetStorage>()),
    );
    gh.lazySingleton<_i609.BaseWeatherLocalDataSource>(
      () => _i609.WeatherLocalDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i517.AuthenticationDatasource>(
      () => _i517.SupabaseDatasource(
        gh<_i454.SupabaseClient>(),
        gh<_i488.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i1007.GatheringDomainRepository>(
      () => _i445.GatheringRepoDatasource(
        gh<_i971.BaseGatheringRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i626.ErrorPageRepositoryDomain>(
      () => _i639.ErrorPageRepositoryData(
        gh<_i781.BaseErrorPageRemoteDataSource>(),
        gh<_i1022.BaseErrorPageLocalDataSource>(),
      ),
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
    gh.lazySingleton<_i97.BaseWeatherRemoteDataSource>(
      () => _i97.WeatherRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i631.BaseBookmarkDataSource>(
      () => _i631.BookmarkRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i18.ProfileDatasource>(
      () => _i18.SupabaseProfileDatasource(
        gh<_i454.SupabaseClient>(),
        gh<_i158.ProfileCacheService>(),
      ),
    );
    gh.lazySingleton<_i936.BookmarkDomainRepository>(
      () => _i1023.BookmarkRepositoryImpl(gh<_i631.BaseBookmarkDataSource>()),
    );
    gh.lazySingleton<_i362.BaseWeatherGetStorageDataSource>(
      () => _i362.WeatherGetStorageDataSource(gh<_i792.GetStorage>()),
    );
    gh.lazySingleton<_i586.EventsDomainRepository>(
      () => _i442.EventsRepositoryData(gh<_i987.BaseEventsRemoteDatasource>()),
    );
    gh.lazySingleton<_i106.TripDomainRepository>(
      () => _i557.TripDataRepository(gh<_i39.TripDataSource>()),
    );
    gh.lazySingleton<_i462.AddBookmarkUseCase>(
      () => _i462.AddBookmarkUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i283.GetUserBookmarkUsecase>(
      () =>
          _i283.GetUserBookmarkUsecase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i601.RemoveBookmarkUseCase>(
      () => _i601.RemoveBookmarkUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i998.ProfileRepository>(
      () => _i121.ProfileRepositoryImpl(gh<_i18.ProfileDatasource>()),
    );
    gh.lazySingleton<_i725.AuthenticationRepositoryDomain>(
      () => _i933.DataRepository(gh<_i517.AuthenticationDatasource>()),
    );
    gh.lazySingleton<_i710.GetEventsUsecase>(
      () => _i710.GetEventsUsecase(gh<_i586.EventsDomainRepository>()),
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
    gh.factory<_i827.UploadImageUseCase>(
      () => _i827.UploadImageUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i753.CreateGatheringUseCase>(
      () =>
          _i753.CreateGatheringUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i390.DeleteGatheringUseCase>(
      () =>
          _i390.DeleteGatheringUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i547.GatheringUsecase>(
      () => _i547.GatheringUsecase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i1066.GetMapEventsUseCase>(
      () => _i1066.GetMapEventsUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i978.GetParticipantsUseCase>(
      () =>
          _i978.GetParticipantsUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i310.JoinEventUseCase>(
      () => _i310.JoinEventUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i1059.SearchEventsUseCase>(
      () => _i1059.SearchEventsUseCase(gh<_i1007.GatheringDomainRepository>()),
    );
    gh.lazySingleton<_i11.AuthenticationUsecases>(
      () => _i11.AuthenticationUsecases(
        authRepo: gh<_i725.AuthenticationRepositoryDomain>(),
      ),
    );
    gh.lazySingleton<_i569.EmergencyRepository>(
      () =>
          emergencyModule.emergencyRepository(gh<_i300.EmergencyDataSource>()),
    );
    gh.factory<_i985.EventCubit>(
      () => _i985.EventCubit(gh<_i710.GetEventsUsecase>()),
    );
    gh.lazySingleton<_i1040.GenerateTripUseCase>(
      () => _i1040.GenerateTripUseCase(gh<_i106.TripDomainRepository>()),
    );
    gh.lazySingleton<_i752.ErrorPageUseCase>(
      () => _i752.ErrorPageUseCase(gh<_i626.ErrorPageRepositoryDomain>()),
    );
    gh.lazySingleton<_i46.WeatherRepositoryDomain>(
      () => _i122.WeatherRepositoryData(
        gh<_i97.BaseWeatherRemoteDataSource>(),
        gh<_i609.BaseWeatherLocalDataSource>(),
        gh<_i362.BaseWeatherGetStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i605.AddBookmarkUseCase>(
      () => _i605.AddBookmarkUseCase(gh<_i936.BookmarkDomainRepository>()),
    );
    gh.lazySingleton<_i50.GetBookmarksUseCase>(
      () => _i50.GetBookmarksUseCase(gh<_i936.BookmarkDomainRepository>()),
    );
    gh.lazySingleton<_i661.GetEventsByIdsUseCase>(
      () => _i661.GetEventsByIdsUseCase(gh<_i936.BookmarkDomainRepository>()),
    );
    gh.lazySingleton<_i664.RemoveBookmarkUseCase>(
      () => _i664.RemoveBookmarkUseCase(gh<_i936.BookmarkDomainRepository>()),
    );
    gh.factory<_i142.GatheringCubit>(
      () => _i142.GatheringCubit(
        gh<_i547.GatheringUsecase>(),
        gh<_i753.CreateGatheringUseCase>(),
        gh<_i390.DeleteGatheringUseCase>(),
        gh<_i1059.SearchEventsUseCase>(),
        gh<_i1066.GetMapEventsUseCase>(),
        gh<_i462.AddBookmarkUseCase>(),
        gh<_i601.RemoveBookmarkUseCase>(),
        gh<_i827.UploadImageUseCase>(),
        gh<_i283.GetUserBookmarkUsecase>(),
        gh<_i310.JoinEventUseCase>(),
        gh<_i978.GetParticipantsUseCase>(),
      ),
    );
    gh.factory<_i5.EventBloc>(
      () => _i5.EventBloc(gh<_i710.GetEventsUsecase>()),
    );
    gh.lazySingleton<_i629.CurrencyExchangeRepository>(
      () => _i909.CurrencyExchangeRepositoryImpl(
        gh<_i20.CurrencyExchangeDatasource>(),
      ),
    );
    gh.singleton<_i680.ProfileUsecase>(
      () => _i680.ProfileUsecase(gh<_i998.ProfileRepository>()),
    );
    gh.lazySingleton<_i324.WeatherUseCase>(
      () => _i324.WeatherUseCase(gh<_i46.WeatherRepositoryDomain>()),
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
    gh.lazySingleton<_i449.EmergencyUseCase>(
      () => emergencyModule.emergencyUseCase(
        gh<_i569.EmergencyRepository>(),
        gh<_i680.ProfileUsecase>(),
      ),
    );
    gh.factory<_i697.EmergencyCubit>(
      () => _i697.EmergencyCubit(gh<_i449.EmergencyUseCase>()),
    );
    gh.factory<_i695.WeatherCubit>(
      () => _i695.WeatherCubit(gh<_i324.WeatherUseCase>()),
    );
    gh.factory<_i197.ProfileCubit>(
      () => _i197.ProfileCubit(gh<_i680.ProfileUsecase>()),
    );
    gh.factory<_i197.BookmarkCubit>(
      () => _i197.BookmarkCubit(
        gh<_i50.GetBookmarksUseCase>(),
        gh<_i661.GetEventsByIdsUseCase>(),
        gh<_i462.AddBookmarkUseCase>(),
        gh<_i601.RemoveBookmarkUseCase>(),
      ),
    );
    gh.factory<_i680.HomeUserInfoCubit>(
      () => _i680.HomeUserInfoCubit(gh<_i680.ProfileUsecase>()),
    );
    gh.factory<_i1002.ErrorPageCubit>(
      () => _i1002.ErrorPageCubit(
        gh<_i752.ErrorPageUseCase>(),
        gh<_i680.ProfileUsecase>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i479.ThirdPartySetup {}

class _$EmergencyModule extends _i313.EmergencyModule {}
