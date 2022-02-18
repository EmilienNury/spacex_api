import 'package:dio/dio.dart';
import 'package:spacex_api/core/model/launch.dart';

class ApiManager {
  Dio dio = Dio();

  static final ApiManager _instance = ApiManager._internal();

  factory ApiManager() => _instance;

  ApiManager._internal() {
    dio.options.baseUrl = "https://api.spacexdata.com/v4";
  }

  List<Launch>? parseLaunches(List<dynamic>? jsonArray) {
    if(jsonArray == null) return null;
    return jsonArray.map<Launch>((json) => Launch.fromJson(json)).toList();
  }

  Launch? parseLaunch(Map<String, dynamic>? json) {
    if(json == null) return null;
    return Launch.fromJson(json);
  }

  Future<List<Launch>?> getUpcomingLaunches() async {
    try {
      List<Launch>? launches = await dio
          .get<List<dynamic>>("/launches/upcoming")
          .then((response) => parseLaunches(response.data));
      return launches;
    } catch (error) {
      print("Erreur : $error");
      return null;
    }
  }

  Future<Launch?> getLaunchDetail(Launch launch) async {
    try {
      Launch? newLaunch = await dio
          .get<Map<String, dynamic>>("/launches/${launch.id}")
          .then((response) => parseLaunch(response.data));
      return newLaunch;
    } catch (error) {
      print("Erreur : $error");
      return null;
    }
  }

  /*Future<Launch?> getDetail(Launch launch) async {
    try {
      Spot? newSpot = await dio
          .get<Map<String, dynamic>>("/spot-details/${spot.id}.json")
          .then((response) => Spot.fromJson(response.data!));
      return newSpot!;
    } catch (error) {
      print("Erreur : $error");
    }
  }*/
}