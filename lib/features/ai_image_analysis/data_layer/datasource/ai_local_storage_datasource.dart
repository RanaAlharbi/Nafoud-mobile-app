import 'package:final_project/core/constants/local_keys.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';


abstract class BaseAiLocalStorageDataSource {
  Future<void> saveAnalysis(String text);
  List<String> getHistory();
}

@LazySingleton(as: BaseAiLocalStorageDataSource)
class AiLocalStorageDataSource implements BaseAiLocalStorageDataSource {
  final GetStorage storage;

  AiLocalStorageDataSource(this.storage);

  @override
  Future<void> saveAnalysis(String text) async {
    List history = storage.read(LocalKeys.landmarkHistory) ?? [];
    history.add(text);
    await storage.write(LocalKeys.landmarkHistory, history);
  }


 @override
  List<String> getHistory() {
    return List<String>.from(storage.read(LocalKeys.landmarkHistory) ?? []);
  }
}
