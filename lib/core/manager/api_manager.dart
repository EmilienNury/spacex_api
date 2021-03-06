import 'package:dio/dio.dart';
import 'package:spacex_api/core/model/launch.dart';

import '../model/launchpad.dart';

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

  List<Launchpad>? parseLaunchpads(List<dynamic>? jsonArray) {
    if(jsonArray == null) return null;
    return jsonArray.map<Launchpad>((json) => Launchpad.fromJson(json)).toList();
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

  Future<List<Launch>?> getPastLaunches() async {
    try {
      List<Launch>? launches = await dio
          .get<List<dynamic>>("/launches/past")
          .then((response) => parseLaunches(response.data));
      return launches;
    } catch (error) {
      print("Erreur : $error");
      return null;
    }
  }

  Future<List<Launchpad>?> getLaunchpads() async {
    try {
      List<Launchpad>? launchpads = await dio
          .get<List<dynamic>>("/launchpads")
          .then((response) => parseLaunchpads(response.data));
      return launchpads;
    } catch (error) {
      print("Erreur : $error");
      return null;
    }
  }

}