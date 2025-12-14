import 'package:final_project/features/gathering/data_layer/datasource/gathering_remote_datasource.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@LazySingleton(as: GatheringDomainRepository)
class GatheringRepoDatasource implements GatheringDomainRepository {
  final BaseGatheringRemoteDataSource remoteDataSource; 

  GatheringRepoDatasource(this.remoteDataSource);


//list of override methods 

  @override
  Future<Result<List<GatheringEntity>, String>> getUsersEvents() async {
    final result = await remoteDataSource.getAllEvents();
    return 
    result.when(
      (events) => Success(events),
      (error) => Error(error));
  }

  @override
  Future<Result<List<GatheringEntity>, String>> getEventsForMap() async {
    final result = await remoteDataSource.getEventsForMap();
    return result.when(
      (events) => Success(events),
      (error) => Error(error));
  }

  @override
  Future<Result<List<GatheringEntity>, String>> searchEvents(
    String keyword,
  ) async {
    final result = await remoteDataSource.searchEvents(keyword);
    return result.when(
      (events) => Success(events),
      (error) => Error(error));
  }


  @override
  Future<Result<void, String>> createUserEvent(GatheringEntity event) {
    final events = GatheringModel(
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
    );

    return remoteDataSource.createUserEvent(events);
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

  @override
  Future<Result<String, String>> uploadImage(String filePath) {
    return remoteDataSource.uploadImage(filePath);
  }

  @override
  Future<Result<List<String>, String>> getUserBookmarks() {
    return remoteDataSource.getUserBookmarks();
  }

  @override
  Future<Result<void, String>> joinEvent(String eventId) {
    return remoteDataSource.joinEvent(eventId);
  }

  @override
  Future<Result<List<String>, String>> getParticipants(String eventId) {
    return remoteDataSource.getParticipants(eventId);
  }
}
