import 'package:flutter/material.dart';
import 'package:spacex_api/core/manager/database_manager.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/launch_list.dart';

class FavoriteLaunches extends StatelessWidget {
  const FavoriteLaunches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataBaseManager().getAllFavLaunches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var favLaunches = snapshot.data as List<Launch>;
          return Scaffold(body: LaunchList(favLaunches.reversed.toList()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ); // trailing comma makes auto-formatting nicer for build methods.
  }
}
