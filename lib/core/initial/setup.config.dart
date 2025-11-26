// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:final_project/core/initial/setup.dart' as _i801;
import 'package:final_project/features/AI_Chatbot/data_layer/datasource/chatbot_datasource.dart'
    as _i41;
import 'package:final_project/features/AI_Chatbot/data_layer/repository/chatbot_repository_data.dart'
    as _i769;
import 'package:final_project/features/AI_Chatbot/domain_layer/repository/chatbot_repository_domain.dart'
    as _i799;
import 'package:final_project/features/AI_Chatbot/domain_layer/usecase/chatbot_usecase.dart'
    as _i466;
import 'package:final_project/features/AI_Chatbot/presentation_layer/bloc/chatbot_bloc.dart'
    as _i63;
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
import 'package:final_project/features/profile/domain_layer/repository/profile_repository.dart'
    as _i682;
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart'
    as _i678;
import 'package:final_project/features/profile/presentation_layer/cubit/profile_cubit.dart'
    as _i295;
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
    gh.lazySingleton<_i115.BaseAiImageAnalysisDataSource>(
      () => _i115.AiImageAnalysisRemoteDataSource(gh<_i656.GenerativeModel>()),
    );
    gh.lazySingleton<_i41.ChatDataSource>(() => _i41.ChatRemoteDataSource());
    gh.lazySingleton<_i123.AiImageAnalysisRepository>(
      () => _i376.AiImageAnalysisRepositoryDataSource(
        gh<_i115.BaseAiImageAnalysisDataSource>(),
      ),
    );
    gh.factory<_i678.ProfileUsecase>(
      () => _i678.ProfileUsecase(gh<_i682.ProfileRepository>()),
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
    gh.factory<_i295.ProfileCubit>(
      () => _i295.ProfileCubit(gh<_i678.ProfileUsecase>()),
    );
    gh.lazySingleton<_i799.ChatbotRepositoryDomain>(
      () => _i769.ChatbotRepositoryData(gh<_i41.ChatDataSource>()),
    );
    gh.factory<_i203.AuthenticationBloc>(
      () => _i203.AuthenticationBloc(gh<_i801.AuthenticationUsecases>()),
    );
    gh.lazySingleton<_i466.GetChatSessionUseCase>(
      () => _i466.GetChatSessionUseCase(gh<_i799.ChatbotRepositoryDomain>()),
    );
    gh.factory<_i63.ChatbotBloc>(
      () => _i63.ChatbotBloc(gh<_i466.GetChatSessionUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartySetup extends _i801.ThirdPartySetup {}
