import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:spacex_api/core/model/launch.dart';

class DataBaseManager {

  static final DataBaseManager _instance = DataBaseManager._internal();

  factory DataBaseManager() => _instance;

  DataBaseManager._internal();

  late Database db;
  late StoreRef<String, Map<String, Object?>> store;

  Future<void> init() async {
    String dataDirectoryPath = (await getApplicationDocumentsDirectory()).path;
    String dbPath = "$dataDirectoryPath/fav_launches.db";
    db = await databaseFactoryIo.openDatabase(dbPath);
    store = stringMapStoreFactory.store("fav_launches");
  }

  Future<List<Launch>> getAllFavLaunches() async {
    List<Launch> launches = [];
    var value = await store.find(db);
    for (var i in value){
      Map<String, dynamic>? storedFavLaunchJson = await store.record(i.key).get(db);
      if (storedFavLaunchJson != null) {
        launches.add(Launch.fromJson(storedFavLaunchJson));
      }
    }
    return launches;
  }

  Future<bool> isFavLaunch(Launch launch) async {
    Map<String, dynamic>? storedFavLaunchJson = await store.record(launch.id).get(db);
    if (storedFavLaunchJson != null) {
      return true;
    }
    return false;
  }

  addFavLaunch(Launch launch) {
    store.record(launch.id).put(db, launch.toJson());
  }

  removeFavLaunch(Launch launch) {
    store.record(launch.id).delete(db);
  }

}