import 'package:final_project/features/gathering/data_layer/datasource/gathering_remote_datasource.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@LazySingleton(as: GatheringDomainRepository)
class GatheringRepoDatasource implements GatheringDomainRepository {
  final BaseGatheringRemoteDataSource remoteDataSource;

  GatheringRepoDatasource(this.remoteDataSource);

  @override
  Future<Result<List<GatheringEntity>, String>> getUsersEvents() async {
    final result = await remoteDataSource.getAllEvents();
    return result.when((models) => Success(models), (error) => Error(error));
  }

  @override
  Future<Result<List<GatheringEntity>, String>> getEventsForMap() async {
    final result = await remoteDataSource.getEventsForMap();
    return result.when((models) => Success(models), (error) => Error(error));
  }

  @override
  Future<Result<List<GatheringEntity>, String>> searchEvents(
    String keyword,
  ) async {
    final result = await remoteDataSource.searchEvents(keyword);
    return result.when((models) => Success(models), (error) => Error(error));
  }

  @override
  Future<Result<void, String>> createUserEvent(GatheringEntity event) {
    final model = GatheringModel(
      id: event.id,
      userId: event.userId,
      title: event.title,
      description: event.description,
      city: event.city,
      date: event.date,
      eventTime: event.eventTime,
      address: event.address,
      imageUrl: event.imageUrl,
      category: event.category,
      latitude: event.latitude,
      longitude: event.longitude,
      isBookmarked: event.isBookmarked,
    );

    return remoteDataSource.createUserEvent(model);
  }

  @override
  Future<Result<void, String>> deleteUserEvent(String id, String userId) {
    return remoteDataSource.deleteUserEvent(id, userId);
  }

  
  @override
  Future<Result<void, String>> addBookmark(String eventId) {
    return remoteDataSource.addBookmark(eventId);
  }

  @override
  Future<Result<void, String>> removeBookmark(String eventId) {
    return remoteDataSource.removeBookmark(eventId);
  }


  
}
