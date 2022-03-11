import 'package:flutter/material.dart';
import 'package:spacex_api/core/manager/api_manager.dart';
import 'package:spacex_api/core/model/launch.dart';
import 'package:spacex_api/ui/components/launch_list.dart';

class PastLaucnhes extends StatelessWidget {
  const PastLaucnhes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager().getPastLaunches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var pastLaunches = snapshot.data as List<Launch>;
          return Scaffold(body: LaunchList(pastLaunches.reversed.toList()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ); // trailing comma makes auto-formatting nicer for build methods.
  }
}
